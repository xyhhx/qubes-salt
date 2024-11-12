# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---
include:
  - common.https_proxy

hardened-chromium:
  pkgrepo.managed:
    - copr: secureblue/hardened-chromium
  pkg.installed: