# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.sysvms.vpn_ivpn %}
{% set template = 'provides-ivpn' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: yellow
      - flags:
        - net
    - prefs:
      - netvm: 'disp-sys-firewall-mirageos-wifi'
    - features:
      - enable:
        - service.clocksync
      - set:
        - menu-items: Alacritty.desktop IVPN.desktop
    - require:
      - qvm: '{{ template }}'
