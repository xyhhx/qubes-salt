{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:net:vpn:ivpn", "sys-vpn-ivpn") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:providers:ivpn", "provides-ivpn") -%}
{%- set netvm = salt["pillar.get"]("vm_names:net:wifi:firewall_mirage", "disp-sys-firewall-mirageos-wifi") -%}

{% if grains.id == 'dom0' %}

include:
  - templates.{{ template }}

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
      - template: '{{ template }}'
      - label: yellow
    - features:
      - enable:
        - service.clocksync
      - set:
        - menu-items: Alacritty.desktop IVPN.desktop
    - require:
      - sls: templates.{{ template }}

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
