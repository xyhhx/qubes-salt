{%- set vm_name = 'provides-vpn-ivpn-k17' -%}
{%- set base_template = 'debian-12-minimal' -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
tags:
  - add:
    - whonix-updatevm
{%- endload -%}

{% from 'utils/macros/create_templatevm.sls' import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{% else %}

{%- set repo_key = '/usr/share/keyrings/ivpn-archive-keyring.asc' %}

'{{ repo_key }}':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/ivpn-archive-keyring.asc'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

'{{ vm_name }}':
  pkgrepo.managed:
    - name: 'deb [arch=amd64 signed-by={{ repo_key }}] https://repo.ivpn.net/stable/debian ./generic main'
    - file: '/etc/apt/sources.list.d/ivpn.list'
    - key_url: 'salt://{{ tpldir }}/files/ivpn-archive-keyring.asc'
    - require:
      - file: '{{ repo_key }}'
  pkg.installed:
    - pkgs:
      - ivpn
      - ivpn-ui
      - qubes-core-agent-networking
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

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
