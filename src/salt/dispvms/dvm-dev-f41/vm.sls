# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% set vm_name = "dvm-dev-f41" %}
{% set template_name = "uses-stack-dev-f41" %}

{% if grains['id'] == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - memory: 8000
      - maxmem: 16000
      - vcpus: 8
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: Alacritty.desktop

'qvm-volume extend {{ vm_name }}:private 12Gi':
  cmd.run:
    - onlyif:
      - 'qvm-ls {{ vm_name }}'
      - '[[ $(qvm-volume info {{ vm_name }}:private size | numfmt --to=iec-i) != 12Gi ]]'

{% endif %}
