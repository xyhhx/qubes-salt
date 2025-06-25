{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:appvms:vault_onlykey", "vault-onlykey") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:uses:onlykey", "uses-app-onlykey") -%}
{% if grains.id == 'dom0' %}

include:
  - templates.{{ template }}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: black
    - prefs:
      - template: '{{ template }}'
      - label: black
      - netvm: ""
      - audiovm: ""
      - memory: 400
      - maxmem: 800
      - vcpus: 2
    - require:
      - sls: templates.{{ template }}
    - tags:
      - add:
        - vault-vm
        - onlykey-server
    - features:
      - set:
        - menu-items: Alacritty.desktop OnlyKey.desktop

{% else %}

{% endif %}
