# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
debian-12-minimal:
  qvm.template_installed

'on-debian-12-minimal.vm - qvm.clone'
  qvm.clone:
   - name: {{ pillar.names.templates.base.debian }}
   - source: debian-12-minimal
