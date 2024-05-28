# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'common.base - update':
  pkg.uptodate:
    - refresh: true

'common.base - install':
  pkg.installed:
    - pkgs:
      - alacritty
      - vim
      - xclip
      - zsh
    - skip_suggestions: true
    - install_recommends: false

include:
  - common.theme
  - common.terminal
