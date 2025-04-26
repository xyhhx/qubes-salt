# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set vm_name = pillar.names.templates.base.kicksecure %}
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
        - kicksecure
        - kicksecure-17
    - features:
      - set:
        - menu-items: Alacritty.desktop

{% endif %}
