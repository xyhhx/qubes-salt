# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'provides-flatpak.vm - qvm.exists':
  qvm.exists:
    - name: {{ pillar.names.templates.base.debian }}

'provides-flatpak.vm - qvm.clone':
  qvm.clone:
    - name: {{ pillar.names.templates.providers.flatpak }}
    - source: {{ pillar.names.templates.base.debian }}
