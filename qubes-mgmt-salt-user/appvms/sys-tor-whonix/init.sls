{%- set vm_name = 'sys-tor-whonix' -%}
{%- set template_name = 'provides-tor-whonix' -%}
{%- set netvm = 'sys-net' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: yellow
      - flags:
        - net
    - prefs:
      - netvm: '{{ netvm }}'
      - template: '{{ template_name }}'
      - label: yellow
      - provides-network: true
    - features:
      - enable:
        - servicevm
        - service.qubes-updates-proxy
      - set:
        - menu-items: {{ [

  'anon_connection_wizard.desktop',
  'gateway-nyx.desktop',
  'whonix-reloadfirewall.desktop',
  'gateway-reloadtor.desktop',
  'restart-tor-gui.desktop',
  'gateway-stoptor.desktop',
  'systemcheck.desktop',
  'thunar.desktop',
  'tor-control-panel.desktop',
  'gateway-tordata.desktop',
  'gateway-torrcexamples.desktop',
  'gateway-torrc.desktop',
  'xfce4-terminal.desktop',
  'sdwdate-gui.desktop'

] | join(' ') }}
    - tags:
      - add:
        - anon-gateway
        - sdwdate-gui-server

'/usr/local/etc/qubes/policy.d/available/30-whonix.policy':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/30-whonix.policy.j2'
    - template: 'jinja'
    - user: 'root'
    - group: 'root'
    - mode: '0640'
    - attrs: 'i'
    - defaults:
        gateway_vm: '{{ vm_name }}'

'/usr/local/etc/qubes/policy.d/enabled/30-whonix.policy':
  file.symlink:
    - target: '/usr/local/etc/qubes/policy.d/available/30-whonix.policy'

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
