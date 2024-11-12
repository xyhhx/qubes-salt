# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---
{% set vm_name = pillar.names.templates.base.kicksecure %}
{% set base_template = 'debian-12-minimal' %}

'{{ base_template }}':
  qvm.template_installed

'{{ vm_name }}':
  qvm.vm:
    - actions:
      - clone
      - prefs
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: black