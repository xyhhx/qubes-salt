{%- set vm_name = 'provides-vpn-ivpn-f42' -%}
{%- set base_template = 'fedora-42-minimal' -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
tags:
  - add:
    - whonix-updatevm
{%- endload -%}

{% from 'utils/macros/create_templatevm.sls' import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{% else %}
'{{ vm_name }}':
  pkgrepo.managed:
    - baseurl: 'https://repo.ivpn.net/stable/fedora/generic/$basearch'
    - gpgkey: 'https://repo.ivpn.net/stable/fedora/generic/repo.gpg'
    - type: 'rpm'
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
  pkg.installed:
    - pkgs:
      - ivpn
      - ivpn-ui
      - qubes-core-agent-networking
      - patch
      - procps-ng
    - skip_suggestions: true
    - install_recommends: false
  file.managed:
    - user: 'root'
    - group: 'root'
    - mode: '0640'
    - makedirs: true
    - names:
      - '/etc/qubes-bind-dirs.d/30-ivpn.conf':
        - source: 'salt://{{ tpldir }}/files/etc/qubes-bind-dirs.d/30-ivpn.conf'
      - '/etc/qubes/qubes-firewall.d/30-leak-prevent.sh':
        - source: 'salt://{{ tpldir }}/files/etc/qubes/qubes-firewall.d/30-leak-prevent.sh'
        - mode: '0750'
{% for file in [
  '/etc/systemd/system/dnat-to-ns.service',
  '/etc/systemd/system/dnat-to-ns.path',
  '/etc/systemd/system/dnat-to-ns-boot.service',
  '/etc/systemd/systemd-resolved-conf.d/override-restart-interval.conf'
] %}
      - '{{ file }}':
        - source: 'salt://{{ tpldir ~ '/files' ~ file }}'
{% endfor %}
  service.enabled:
    - names:
      - 'dnat-to-ns.path'
      - 'dnat-to-ns-boot.service'

'/rw/bind-dirs/etc/opt/ivpn/mutable':
  file.directory:
    - makedirs: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
