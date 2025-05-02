# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "dvm-fedora-41-xfce" %}
{% set template_name = "on-fedora-41-xfce" %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template-for-dispvms: true
    - features:
      - set:
        - menu-favorites: "@disp:org.mozilla.firefox @disp:thunar @disp:xfce4-terminal"


'{{ vm_name }}-offline':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: gray
    - prefs:
      - template-for-dispvms: true
    - features:
      - set:
        - menu-favorites: "@disp:thunar @disp:xfce4-terminal"

{% endif %}

