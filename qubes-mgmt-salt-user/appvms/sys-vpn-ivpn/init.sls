{%- set vm_name = 'sys-vpn-ivpn' -%}
{%- set template_name = 'provides-vpn-ivpn' -%}
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
    - features:
      - enable:
        - service.clocksync
      - set:
        - menu-items: Alacritty.desktop IVPN.desktop

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
