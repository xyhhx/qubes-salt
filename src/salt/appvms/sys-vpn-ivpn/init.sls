# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.sysvms.vpn_ivpn %}
{% set template = salt["pillar.get"]("vm_names:templates:providers:ivpn") %}
{% set netvm = 'disp-sys-firewall-mirageos-wifi' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: yellow
      - flags:
        - net
      - require:
        - qvm: '{{ template }}'
        - qvm: '{{ netvm }}'
    - prefs:
      - netvm: '{{ netvm }}'
    - features:
      - enable:
        - service.clocksync
      - set:
        - menu-items: Alacritty.desktop IVPN.desktop

{% else %}

/rw/config/qubes-firewall-user-script:
  file.managed:
    - user: root
    - group: root
    - mode: '0750'
    - makedirs: true
    - content: |-
        nft add rule qubes custom-forward oifname eth0 counter drop
        nft add rule ip6 qubes custom-forward oifname eth0 counter drop


{% endif %}
