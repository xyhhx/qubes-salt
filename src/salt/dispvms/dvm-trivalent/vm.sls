# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% set vm_name = "dvm-trivalent" %}
{% set template_name = "uses-app-trivalent" %

{% if grains['id'] == 'dom0' %}

'{{ vm_name }}.vm':
  qvm.vm:
    - name: '{{ vm_name }}'
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template-for-dispvms: true

{% endif %}
