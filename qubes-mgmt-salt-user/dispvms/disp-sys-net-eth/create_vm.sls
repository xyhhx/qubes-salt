{%- if grains.id == "dom0" -%}
{%- set vm_name = "disp-sys-net-eth" -%}
{%- set template_name = "dvm-sys-net" -%}
{%- from "utils/pci_net_devs.jinja" import eth_devs -%}

include:
  - templates.provides-net

"{{ vm_name }}":
  qvm.vm:
    - require:
      - sls: templates.provides-net
    - present:
      - class: DispVM
      - template: "{{ template_name }}"
    - prefs:
      - template: "{{ template_name }}"
      - label: red
      - mem: 300
      - maxmem: 300
      - vcpus: 1
      - netvm: ""
      - audiovm: ""
      - virt-mode: hvm
      - provides-network: true
      - pcidevs: {{ eth_devs | yaml }}
      - pci_strictreset: false
    - service:
      - enable:
        - clocksync
        - minimal-netvm

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
