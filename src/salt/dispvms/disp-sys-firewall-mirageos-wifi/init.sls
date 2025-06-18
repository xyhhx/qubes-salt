{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:net:wifi:firewall_mirage") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:providers:firewall_mirageos") -%}
{%- set netvm = salt["pillar.get"]("vm_names:net:wifi:net") -%}

{% if grains.id == 'dom0' %}

'{{ netvm }}':
  qvm.exists

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: DispVM
      - template: '{{ template }}'
      - label: orange
      - flags:
        - net
    - prefs:
      - template: '{{ template }}'
      - label: orange
      - netvm: '{{ netvm }}'
      - memory: 32
      - maxmem: 0
      - vcpus: 1
      - provides-network: true
    - features:
      - enable:
        - qubes-firewall
        - no-default-kernelopts

{% endif %}
