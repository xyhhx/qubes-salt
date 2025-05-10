# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "provides-onlykey" %}
{% set base_template = 'fedora-41-minimal' %}

{% if grains.id == 'dom0' %}

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
    - features:
      - enable:
        - service.updates-proxy-setup

{% endif %}
