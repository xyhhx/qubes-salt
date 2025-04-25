# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['id'] != 'dom0' %}

# Set vm_name from pillar data
{% set vm_name = 'sys-vpn-ivpn' %}

/rw/config/qubes-firewall-user-script:
  file.managed:
    - user: root
    - group: root
    - mode: '0750'
    - makedirs: true
    - content: |-
        nft add rule qubes custom-forward oifname eth0 counter drop
        nft add rule ip6 qubes custom-forward oifname eth0 counter drop

dnat-to-ns.path:
  service.enabled

dnat-to-ns-boot.service:
  service.enabled

{% endif %}
