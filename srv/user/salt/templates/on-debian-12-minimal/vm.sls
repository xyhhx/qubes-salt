# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
debian-12-minimal:
  qvm.template_installed

{{ pillar.names.templates.base.debian_minimal }}
  qvm.clone:
   - source: debian-12-minimal
