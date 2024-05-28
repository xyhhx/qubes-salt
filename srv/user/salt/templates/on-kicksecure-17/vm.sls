# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'on-kicksecure-17.vm - preinstall':
  qvm.exists:
    - name: {{ pillar.names.templates.base.debian }}

'on-kicksecure-17.vm - clone':
  qvm.clone:
    - name: {{ pillar.names.templates.base.kicksecure }}
    - source: {{ pillar.names.templates.base.debian }}
