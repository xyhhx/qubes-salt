# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.sysvms.vpn_ivpn %}
{% set template = 'provides-ivpn' %}
{% set netvm = 'disp-sys-firewall-mirageos-wifi' %}

'{{ netvm }}':
  qvm.exists

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: yellow
      - flags:
        - net
    - prefs:
      - netvm: '{{ netvm }}'
    - features:
      - enable:
        - service.clocksync
      - set:
        - menu-items: Alacritty.desktop IVPN.desktop
    - require:
      - qvm: '{{ template }}'
      - qvm: '{{ netvm }}'
