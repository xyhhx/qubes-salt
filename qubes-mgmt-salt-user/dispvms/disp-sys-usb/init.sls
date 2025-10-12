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

'/usr/local/etc/qubes/policy.d/available/30-dispvm-usb-input.policy':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/usb-input.policy.j2'
    - template: 'jinja'
    - user: 'root'
    - group: 'qubes'
    - mode: '0640'
    - attrs: 'i'
    - makedirs: true
    - replace: true
    - defaults:
        usb_qube: '{{ vm_name }}'
        keyboard_policy: 'qubes.InputKeyboard'
        keyboard_policy_action: 'ask'
        mouse_policy: 'qubes.InputMouse'
        mouse_policy_action: 'ask'
        tablet_policy: 'qubes.InputTablet'
        tablet_policy_action: 'deny'

'/usr/local/etc/qubes/policy.d/enabled/30-dispvm-usb-input.policy':
  file.symlink:
    - target: '/usr/local/etc/qubes/policy.d/available/30-dispvm-usb-input.policy'
    - user: 'root'
    - group: 'qubes'
    - mode: '0640'
    - makedirs: true

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

