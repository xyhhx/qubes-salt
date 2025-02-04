# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'common.networking - update':
  pkg.uptodate:
    - refresh: true

'common.networking - install':
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
{% if grains['os_family']|lower == 'redhat' %}
      - NetworkManager-wifi
      - network-manager-applet
      - notification-daemon
      - polkit
      - @hardware-support
{% elif grains['os_family']|lower == 'redhat' %}
      - wpasupplicant
      - ntpd
{% endif %}
    - skip_suggestions: true
    - install_recommends: false
    - order: 1

