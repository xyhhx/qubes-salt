# vim: set ts=2 sw=2 sts=2 et :

---
{% set vm_name = 'on-debian-12-minimal' %}
{% set base_template = 'debian-12-minimal' %}

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
        - debian
        - debian-12
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% endif %}
