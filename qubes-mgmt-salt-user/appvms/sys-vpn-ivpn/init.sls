{%- set vm_name = 'sys-vpn-ivpn' -%}
{%- set template_name = 'provides-vpn-ivpn-k17' -%}

{%- if grains.id == 'dom0' -%}

{%- set mfw_name = 'sys-mfw-ivpn' -%}
{%- from 'utils/macros/create-standalone-mirageos-firewall.sls' import create_standalone_mirageos_firewall -%}
{{ create_standalone_mirageos_firewall(mfw_name, vm_options={ 'netvm': 'sys-net' }) }}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: yellow
      - flags:
        - net
    - prefs:
      - netvm: '{{ mfw_name }}'
      - template: '{{ template_name }}'
      - label: yellow
    - features:
      - enable:
        - service.clocksync
      - set:
        - menu-items: Alacritty.desktop IVPN.desktop

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
