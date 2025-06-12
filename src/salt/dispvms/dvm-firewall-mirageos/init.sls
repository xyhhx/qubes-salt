{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:dispvms:firewall_mirageos") -%}
{%- set template_name = salt["pillar.get"]("vm_names:templates:providers:firewall_mirageos") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: AppVM
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - memory: 32
      - maxmem: 0
      - vcpus: 1
      - template-for-dispvms: true
      - provides-network: true
    - features:
      - enable:
        - qubes-firewall
        - no-default-kernelopts

{% endif %}
