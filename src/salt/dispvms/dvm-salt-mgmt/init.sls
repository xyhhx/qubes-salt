{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:dispvms:salt_mgmt") -%}
{%- set template_name = salt["pillar.get"]("vm_names:templates:uses:salt_mgmt") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: {{ template_name }}
      - label: black
    - prefs:
      - template: {{ template_name }}
      - audiovm: ""
      - autostart: False
      - dispvm-allowed: True
      - include_in_backups: False
      - label: black
      - maxmem: 600
      - memory: 300
      - netvm: ""
      - template_for_dispvms: True
      - vcpus: 1
    - features:
      - enable:
        - appmenus-dispvm
        - internal
    - tags:
      - add:
        - salt-mgmt

{% endif %}
