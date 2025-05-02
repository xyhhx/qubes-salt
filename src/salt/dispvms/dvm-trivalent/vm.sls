# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "dvm-trivalent" %}
{% set template_name = "uses-app-trivalent" %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: trivalent.desktop
        - menu-favorites: "@disp:trivalent"

{% endif %}
