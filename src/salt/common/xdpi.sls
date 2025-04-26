# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

/etc/X11/Xresources:
  file.replace:
    - pattern: |-
        Xft.dpi: 96
    - repl: |-
        Xft.dpi: 192
