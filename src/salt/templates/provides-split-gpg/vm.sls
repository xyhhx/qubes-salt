# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set vm_name = 'provides-split-gpg' %}
{% set base_template = 'fedora-41-minimal' %}

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
        - fedora
        - fedora-41

