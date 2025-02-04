
# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'common.pkgs.audio - update':
  pkg.uptodate:
    - refresh: true

'common.pkgs.audio - install':
  pkg.installed:
    - pkgs:
      - pipewire
      - pipewire-qubes
      - pipewire-pulseaudio
      - wireplumber
      - alsa-utils
    - skip_suggestions: true
    - install_recommends: false
    - order: 1

