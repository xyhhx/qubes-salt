{%- set vm_name = "provides-firewall-mirageos" -%}

{% if grains.id == 'dom0' %}

{#- TODO: Move to pillar -#}
{%- load_yaml as mirage_options -%}
release: 'v0.9.4'
checksum: '0c3c2c0e62a834112c69d7cddc5dd6f70ecb93afa988768fb860ed26e423b1f8'
{%- endload -%}

{%- from 'utils/macros/download_mirage_kernel.sls' import download_mirage_kernel -%}
{{ download_mirage_kernel(options=mirage_options) }}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: 'TemplateVM'
      - label: 'black'
    - prefs:
      - label: 'black'
      - memory: 64
      - maxmem: 0
      - vcpus: 1
      - kernel: 'mirage-firewall-{{ mirage_options.release }}'
      - kernelopts: ''
      - autostart: false
      - debug: false
      - include-in-backups: false
      - internal: false
    - features:
      - enable:
        - no-default-kernelopts
        - skip-update

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
