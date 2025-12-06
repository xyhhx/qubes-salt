{%- set vm_name = 'dvm-mgmt' -%}
{%- set template_name = 'provides-mgmt' -%}

{%- if grains.id == 'dom0' -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: black
      - mem: 300
    - prefs:
      - template: '{{ template_name }}'
      - label: red
      - netvm: ''
      - template-for-dispvms: true
    - features:
      - internal

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
