# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'provides-flatpak.configure - install':
  pkg.installed
    - pkgs:
      - flatpak
      - flatseal
