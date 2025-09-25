{%- set vm_name = 'dvm-sys-net' -%}
{%- set template_name = 'provides-net' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
      - mem: 300
    - prefs:
      - template: '{{ template_name }}'
      - label: red
      - netvm: ''
      - virt-mode: hvm
      - provides-network: true
      - template-for-dispvms: true
    - require:
      - qvm: provides-net
    - service:
      - enable:
        - clocksync
        - minimal-netvm
      - disable:
        - meminfo-writer

{% endif %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
