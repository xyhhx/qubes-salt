# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set vm_name = "on-fedora-41-xfce" %}
{% set base_template = 'fedora-41-xfce' %}

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
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% endif %}
