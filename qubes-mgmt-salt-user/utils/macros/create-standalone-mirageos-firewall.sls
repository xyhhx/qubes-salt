{%- macro create_standalone_mirageos_firewall(vm_name, mirage_options={}, vm_options={}) -%}
{%- if grains.id == 'dom0' -%}

{#-
  This macro creates a standalone mirage firewall instance
-#}

{%- load_yaml as mirage_defaults -%}
release: 'v0.9.4'
checksum: '0c3c2c0e62a834112c69d7cddc5dd6f70ecb93afa988768fb860ed26e423b1f8'
{%- endload -%}

{%- set mirage = {} -%}
{%- do salt['defaults.merge'](mirage, mirage_defaults, in_place=true) -%}
{%- do salt['defaults.merge'](mirage, mirage_options, in_place=true) -%}

{%- load_yaml as vm_defaults -%}
memory: 64
label: 'yellow'
{%- endload -%}

{%- from 'utils/macros/download_mirage_kernel.sls' import download_mirage_kernel -%}
{{ download_mirage_kernel(options=mirage) }}

{%- set vm = {} -%}
{%- do salt["defaults.merge"](vm, vm_defaults, in_place=true) -%}
{%- do salt["defaults.merge"](vm, vm_options, in_place=true) -%}

{%- if vm_options.netvm is not defined -%}
{%- set default_netvm = salt['cmd.shell']('qubes-prefs -- default_netvm') -%}
{%- set netvm = salt['cmd.shell']('qvm-prefs -- ' ~ default_netvm ~ ' netvm') -%}
{%- else -%}
{%- set netvm = vm_options.netvm -%}
{%- endif -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: 'StandaloneVM'
      - label: '{{ vm.label }}'
    - prefs:
      - label: '{{ vm.label }}'
      - memory: {{ vm.memory }}
      - maxmem: 0
      - vcpus: 1
      - netvm: '{{ netvm }}'
      - kernel: 'mirage-firewall-{{ mirage.release }}'
      - kernelopts: ''
      - autostart: false
      - debug: false
      - include-in-backups: false
      - internal: false
      - provides-network: true
    - features:
      - enable:
        - no-default-kernelopts
        - skip-update

{%- endif -%}
{%- endmacro -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
