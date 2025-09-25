{%- set vm_name = 'sys-firewall-linux' -%}
{%- set template_name = 'provides-firewall-linux' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: yellow
    - prefs:
      - template: '{{ template_name }}'
      - label: yellow
      - netvm: sys-net
      - provides-network: true
      - memory: 500
    - require:
      - qvm: provides-firewall-linux

{% endif %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
