# vim: set ts=2 sw=2 sts=2 et sts :

---
{% set vm_name = "provides-flatpak" %}
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
        - default-menu-items: com.github.tchx84.Flatseal.desktop io.github.flattool.Warehouse Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% endif %}
