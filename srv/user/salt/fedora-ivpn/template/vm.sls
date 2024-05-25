# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
provides-ivpn-fedora_template:
  qvm.clone:
    - name: {{ pillar['names']['templates']['provides_ivpn_fedora'] }}
    - source: {{ pillar['names']['base_templates']['fedora_minimal'] }}
