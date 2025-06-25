{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:sysvms:onlykey", "sys-onlykey") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:providers:onlykey", "provides-onlykey") -%}

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
    - tags:
      - add:
        - sys-vm
        - onlykey-server
    - require:
      - sls: templates.{{ template }}

/etc/qubes/policy.d/user.d/49-onlykey.policy:
  file.managed:
    - source: salt://appvms/sys-onlykey/files/49-onlykey.policy
    - template: jinja
    - mode: "0644"
    - makedirs: true
    - defaults:
        onlykey_vm: "sys-onlykey"
    - context:
        onlykey_vm: "{{ vm_name }}"

{% endif %}
