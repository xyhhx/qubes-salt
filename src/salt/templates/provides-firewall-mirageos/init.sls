{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---
{% set vm_name = salt["pillar.get"]("vm_names:templates:providers:firewall_mirageos") %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: TemplateVM
      - label: gray
      - flags:
        - quiet
    - prefs:
      - kernel: '{{ "mirage-firewall-" ~ pillar.config.versions.mirageos }}'
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
