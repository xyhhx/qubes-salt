# vim: set ts=2 sw=2 sts=2 et :

---
{% set vm_name = pillar.names.templates.base.gateway %}
{% set base_template = 'whonix-gateway-17' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - anon-gateway
        - whonix
        - whonix-17
        - whonix-gateway
    - require:
      - qvm: '{{ base_template }}'

{% endif %}
