{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id == 'dom0' %}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:firewall_mirageos") -%}
{%- set mirage_version = salt["pillar.get"]("qvm:versions:mirageos", "v0.9.4") -%}
{%- set kernel = "mirage-firewall" ~ mirage_version -%}

include:
  - .kernel

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: TemplateVM
      - label: gray
      - flags:
        - quiet
    - prefs:
      - kernel: '{{ kernel }}'
      - kernelopts: ''
      - include_in_backups: false
      - memory: 32
      - maxmem: 0
    - features:
      - enable:
        - no-default-kernelopts
    - tags:
      - add:
        - salt-managed
        - mirage-os

{% endif %}
