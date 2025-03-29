# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
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
    - skip_suggestions: true
    - install_recommends: false
    - order: 1

