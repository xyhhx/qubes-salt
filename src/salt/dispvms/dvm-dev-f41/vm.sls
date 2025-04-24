# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% set vm_name = "dvm-dev-f41" %}
{% set template_name = "uses-stack-dev-f41" %

{% if grains['id'] == 'dom0' %}

'{{ vm_name }}.vm':
  qvm.vm:
    - name: '{{ vm_name }}'
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - memory: 8000
      - maxmem: 16000
      - vcpus: 8
      - template-for-dispvms: true

'qvm-volume extend {{ vm_name }}:private 12Gi':
  cmd.run

'qvm-appmenus --update {{ vm_name }}':
  cmd.run:
    - runas: '{{ pillar.defaults.dom0_user }}'

{% endif %}
