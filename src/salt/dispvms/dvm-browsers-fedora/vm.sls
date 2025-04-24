# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% set vm_name = pillar.names.dispvms.browsers_fedora %}
{% set template_name = pillar.names.template.browsers_fedora %

{% if grains['id'] == 'dom0' %}

'{{ vm_name }}.vm':
  qvm.vm:
    - name: '{{ vm_name }}'
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template-for-dispvms: true

'qvm-volume extend {{ vm_name }}:private 12Gi':
  cmd.run

{% endif %}
