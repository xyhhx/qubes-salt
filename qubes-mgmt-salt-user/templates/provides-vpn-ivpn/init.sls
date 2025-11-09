{%- set vm_name = 'provides-vpn-ivpn' -%}
{%- set base_template = 'debian-13-minimal' -%}

{%- if grains.id == 'dom0' -%}

{%- load_yaml as options -%}
features:
  - remove:
    - selinux
tags:
  - add:
    - whonix-updatevm
{%- endload -%}

{%- from 'utils/macros/create_templatevm.sls' import templatevm -%}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{%- else -%}

{%- load_yaml as repo -%}
key: '/usr/share/keyrings/ivpn-archive-keyring.asc'
url: 'https://repo.ivpn.net/stable/debian'
{%- endload -%}

include:
  - common.hardening.kicksecure

'{{ vm_name }}':
  pkgrepo.managed:
    - name: 'deb [arch=amd64 signed-by={{ repo.key }}] {{ repo.url }} ./generic main'
    - file: '/etc/apt/sources.list.d/ivpn.list'
    - key_url: 'salt://{{ tpldir }}/files/ivpn-archive-keyring.asc'
    - require:
      - sls: common.hardening.kicksecure
  pkg.installed:
    - pkgs:
      - libasound2t64
      - ivpn
      - ivpn-ui
      - qubes-core-agent-networking
    - install_recommends: false
    - require:
      - pkgrepo: '{{ vm_name }}'

'{{ slsdotpath }}:confs':
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
  '/etc/systemd/system/ivpn-autoconnect.service',
  '/etc/systemd/systemd-resolved-conf.d/override-restart-interval.conf',
  '/usr/lib/ivpn/ivpn-autoconnect.sh'
] %}
      - '{{ file }}':
        - source: 'salt://{{ tpldir ~ '/files' ~ file }}'
{% endfor %}
    - require:
      - pkg: '{{ vm_name }}'
  service.enabled:
    - names:
      - 'ivpn-autoconnect.service'
      - 'dnat-to-ns.path'
      - 'dnat-to-ns-boot.service'

'/rw/bind-dirs/etc/opt/ivpn/mutable':
  file.directory:
    - makedirs: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
