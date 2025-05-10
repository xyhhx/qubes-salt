# vim: set ts=2 sw=2 sts=2 et :

---
{% set name = "common.pkgs.networking" %}

{% if grains.id != 'dom0' %}

'{{ name }} - install':
  pkg.installed:
    - pkgs:
      - pciutils
      - psmisc
      - gnome-keyring
      - qubes-core-agent-networking
      - qubes-core-agent-network-manager
      - telnet
      - tcpdump
      - nmap
      - netcat
    - skip_suggestions: true
    - install_recommends: false
    - order: 1
    - aggregate: true

{% endif %}
