# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'flatpak --user install -y --noninteractive io.github.ungoogled_software.ungoogled_chromium':
  cmd.run:
    - runas: user

'flatpak --user install -y --noninteractive io.gitlab.librewolf-community':
  cmd.run:
    - runas: user

