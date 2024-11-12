
# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
/home/user/.config/alacritty/alacritty.yml:
  file.managed:
    - makedirs: true
    - source: salt://common/terminal/files/alacritty.yml

/etc/skel/.config/alacritty/alacritty.yml:
  file.managed:
    - makedirs: true
    - source: salt://common/terminal/files/alacritty.yml
