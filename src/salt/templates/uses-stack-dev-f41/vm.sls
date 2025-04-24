# vim: set syntax=yaml ts=2 sw=2 sts=2 et sts :

---
{% set vm_name = "uses-stack-dev-f41" %}
{% set base_template = 'fedora-41-minimal' %}

'{{ base_template }}':
  qvm.template_installed

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41

