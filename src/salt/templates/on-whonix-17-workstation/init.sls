{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:os:whonix_ws") -%}
{%- set base_template = salt["pillar.get"]("base_templates:whonix:ws") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - anon-vm
        - whonix
        - whonix-17
        - whonix-workstation
    - require:
      - qvm: '{{ base_template }}'

{% endif %}
