# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'common.shell - install alacritty':
  pkg.installed:
    - pkgs:
      - alacritty

'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 10':
  cmd.run

'update-alternatives --set x-terminal-emulator $(which alacritty)':
  cmd.run

'common.shell - alacritty.yml':
  file.managed:
    - name: '/home/user/.config/alacritty/alacritty.yml'
    - source:
      - file: 'salt://common/terminal/files/alacritty.yml'
