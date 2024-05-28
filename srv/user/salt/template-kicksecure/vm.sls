# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'template-kicksecure.vm - preinstall':
  qvm.exists:
    - name: {{ pillar['names']['base_templates']['debian_minimal'] }}

'template-kicksecure.vm - clone':
  qvm.clone:
    - name: {{ pillar['names']['base_templates']['kicksecure'] }}
    - source: {{ pillar['names']['base_templates']['debian_minimal'] }}
