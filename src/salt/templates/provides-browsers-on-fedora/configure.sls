# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
include:
  - common.https_proxy

trivalent:
  pkgrepo.managed:
    - copr: secureblue/trivalent
  pkg.installed:
    - trivalent
