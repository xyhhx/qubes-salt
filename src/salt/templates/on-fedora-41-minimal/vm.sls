# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set vm_name = "on-fedora-41-minimal" %}
{% set base_template = 'fedora-41-minimal' %}

'{{ base_template }}':
  qvm.template_installed

'{{ vm_name }}':
  qvm.vm:
    - actions:
      - clone
      - prefs
      - tags
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
