# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
install deps:
  pkg.installed:
    - pkgs:
      - pciutils
      - vim-minimal
      - less
      - psmisc
      - gnome-keyring
      - qubes-core-agent-networking
      - notification-daemon
      - polkit
      - python3-urllib3 
/etc/qubes-bind-dirs.d/50_user.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
    - source: salt://fedora-ivpn/template/files/bind-50_user.conf
ivpn-stable:
  pkgrepo.managed:
    - humanname: IVPN software
    - baseurl: https://repo.ivpn.net/stable/fedora/generic/$basearch
    - gpgcheck: 1
    - gpgkey: https://repo.ivpn.net/stable/fedora/generic/repo.gpg
install ivpn:
  pkg.installed:
    - pkgs:
      - ivpn-ui 
/etc/systemd/system/dnat-to-ns.service:
  file.managed:
    - user: root
    - group: root
    - mode: 755 
    - source: salt://fedora-ivpn/template/files/dnat-to-ns.service
/etc/systemd/system/dnat-to-ns.path:
  file.managed:
    - user: root
    - group: root
    - mode: 755
    - souirce: salt://fedora-ivpn/template/files/dnat-to-service.path
/etc/systemd/system/systemd-resolved.conf.d/override.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 755 
    - makedirs: true
    - source: salt://fedora-ivpn/template/files/resolved-override.conf
# this doesn't work???  
# systemctl enable dnat-to-ns.path: 
#   cmd.run 
