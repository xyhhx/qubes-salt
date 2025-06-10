# vim: set ts=2 sw=2 sts=2 et sts :

---
{% set vm_name = salt["pillar.get"]("vm_names:templates:providers:appimage") %}
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
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

fuse-libs:
  pkg.installed

{% endif %}
