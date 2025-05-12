# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = "app-libreoffice" %}
{% set template = "uses-app-libreoffice" %}
{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: blue
    - features:
      - set:
        - menu-items: libreoffice-base.desktop libreoffice-calc.desktop libreoffice-draw.desktop libreoffice-impress.desktop libreoffice-math.desktop libreoffice-writer.desktop
    - require:
      - qvm: '{{ template }}'

{% endif %}
