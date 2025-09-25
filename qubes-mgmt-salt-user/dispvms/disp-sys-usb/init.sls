{%- set vm_name = "disp-sys-usb" -%}
{%- set template_name = "dvm-sys-usb" -%}

{% if grains.id == 'dom0' %}

{%- from './usb_devices.jinja' import usb_pcidevs with context -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: DispVM
      - template: '{{ template_name }}'
      - label: red
      - mem: 300
      - flags:
        - net
    - prefs:
      - netvm: ''
      - virt_mode: hvm
      - autostart: true
      - pcidevs: {{ usb_pcidevs | yaml }}
      - pci_strictreset: false
      - netvm: 'none'
      - virt_mode: 'hvm'
    - service:
      - disable:
        - network-manager
        - meminfo-writer
      - enable:
        - minimal-usbvm
  file.managed:
    - name: '/etc/qubes/policy.d/30-dispvm-usb-input.policy'
    - source: 'salt://dispvms/disp-sys-usb/files/usb-input.policy'
    - template: 'jinja'
    - replace: true
    - user: root
    - group: qubes
    - mode: '0640'
    - makedirs: true
    - defaults:
        usb_qube: '{{ vm_name }}'
        keyboard_policy: 'qubes.InputKeyboard'
        keyboard_policy_action: 'ask'
        mouse_policy: 'qubes.InputMouse'
        mouse_policy_action: 'ask'
        tablet_policy: 'qubes.InputTablet'
        tablet_policy_action: 'deny'

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

