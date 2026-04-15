{%- set vm_name = 'disp-sys-net-eth' -%}
{%- set template_name = 'dvm-sys-net' -%}

{% if grains.id == 'dom0' %}

{%- from 'utils/pci_net_devs.jinja' import eth_devs -%}

{%- do salt['log.debug'](eth_devs) -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: DispVM
      - template: '{{ template_name }}'
      - label: red
      - mem: 300
    - prefs:
      - template: '{{ template_name }}'
      - label: red
      - netvm: ''
      - virt-mode: hvm
      - provides-network: true
      - pcidevs: {{ eth_devs | yaml }}
      - pci_strictreset: false
    - require:
      - qvm: provides-net
    - service:
      - enable:
        - clocksync
        - minimal-netvm
      - disable:
        - meminfo-writer

{% endif %}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
