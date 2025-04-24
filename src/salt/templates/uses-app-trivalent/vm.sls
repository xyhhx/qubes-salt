# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set vm_name = "uses-app-trivalent" %}
{% set base_template = 'fedora-41-minimal' %}

'{{ vm_name }}':
  qvm:
    - template_installed
    - name: '{{ base_template }}'
    - vm
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - uses-app
