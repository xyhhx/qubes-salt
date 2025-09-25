{%- set vm_name = "dvm-sys-usb" -%}
{%- set template_name = "provides-usb" -%}

{% if grains.id == 'dom0' %}


'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
      - mem: 300
      - flags:
        - net
    - prefs:
      - template_for_dispvms: true
      - netvm: ''
      - virt_mode: hvm
    - service:
      - disable:
        - network-manager
        - meminfo-writer
      - enable:
        - minimal-usbvm

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

