
# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---
/home/user/.config/alacritty/alacritty.toml:
  file.managed:
    - makedirs: true
    - source: salt://common/terminal/files/alacritty.toml

/etc/skel/.config/alacritty/alacritty.toml:
  file.managed:
    - makedirs: true
    - source: salt://common/terminal/files/alacritty.toml