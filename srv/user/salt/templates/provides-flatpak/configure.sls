# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
flatpak:
  pkg.installed

/etc/systemd/system/update-flatpak-user.service:
  file.managed:
    - source: salt://templates/provides-flatpak/files/update-flatpak-user.service
    - user: root
    - group: root
    - mode: 755
