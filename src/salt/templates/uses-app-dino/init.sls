# vim: set ts=2 sw=2 sts=2 et :

---
{% set vm_name = "uses-app-dino" %}
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
        - uses-app
    - features:
      - set:
        - menu-items: Alacritty.desktop im.dino.Dino.desktop
        - default-menu-items: Alacritty.desktop im.dino.Dino.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

dino:
  pkg.installed

{% endif %}
