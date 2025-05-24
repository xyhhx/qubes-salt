# vim: set ts=2 sw=2 sts=2 et :

---
{% set vm_name = pillar.names.templates.base.whonix_gw %}
{% set base_template = 'whonix-workstation-17' %}

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
        - anon-vm
        - whonix
        - whonix-17
        - whonix-workstation
    - require:
      - qvm: '{{ base_template }}'

{% endif %}
