
# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'/home/{{ user }}/.local/bin/center-window-xfce.sh':
  file.managed:
    - source: 'salt://dom0/files/center-window-xfce.sh'
    - makedirs: true
    - mode: '0750'

