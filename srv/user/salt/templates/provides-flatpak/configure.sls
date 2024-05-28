# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
flatpak:
  pkg.installed

'all_proxy=http://127.0.0.1:8082 flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo':
  cmd.run

/etc/systemd/system/update-flatpak-user.service:
  file.managed:
    - source: salt://templates/provides-flatpak/files/update-flatpak-user.service
    - user: root
    - group: root
    - mode: 755
