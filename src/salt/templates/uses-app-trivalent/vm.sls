# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set vm_name = "uses-app-trivalent" %}
{% set base_template = 'fedora-41-minimal' %}
{% set name = "templates.uses-app-trivalent.vm" %}

'{{ vm_name }}':
  qvm:
    - template_installed
    - vm:
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
