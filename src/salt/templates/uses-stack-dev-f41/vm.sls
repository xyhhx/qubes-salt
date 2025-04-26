# vim: set syntax=yaml ts=2 sw=2 sts=2 et sts :

---
{% set vm_name = "uses-stack-dev-f41" %}
{% set base_template = 'fedora-41-minimal' %}

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
        - fedora
        - fedora-41
        - uses-stack
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% endif %}
