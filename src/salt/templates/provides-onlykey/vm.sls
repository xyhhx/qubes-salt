# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "provides-onlykey" %}
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

'{{ vm_name }}':
  qvm.service:
    - enable:
      - updates-proxy-setup

