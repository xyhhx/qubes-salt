# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "dvm-librewolf-f41" %}
{% set template_name = "uses-app-librewolf-f41" %}

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
        - service.qubes-ctap-proxy
      - set:
        - menu-items: librewolf.desktop
        - menu-favorites: "@disp:librewolf"

{% endif %}
