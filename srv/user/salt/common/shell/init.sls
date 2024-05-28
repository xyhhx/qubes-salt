# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
alacritty:
  pkg.installed

'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 10':
  cmd.run

'update-alternatives --set x-terminal-emulator $(which alacritty)':
  cmd.run

/home/user/.config/alacritty/alacritty.yml:
  file.managed:
    - makedirs: true
    - source: salt://common/shell/files/alacritty.yml
