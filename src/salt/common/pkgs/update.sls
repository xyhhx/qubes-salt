# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
include:
  - base: salt://update/qubes-vm

do_upgrade:
  pkg.upgrade:
    - require:
      - sls: qubes-vm
