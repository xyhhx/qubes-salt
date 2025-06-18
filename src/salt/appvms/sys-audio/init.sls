{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:sysvms:audio", "sys-audio") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:providers:audio", "provides-audio") -%}

{% if grains.id == 'dom0' %}

include:
  - templates.{{ template }}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: yellow
      - netvm: ""
    - prefs:
      - template: '{{ template }}'
      - label: yellow
      - netvm: ""
    - require:
      - sls: templates.{{ template }}

/etc/qubes/policy.d/user.d/30-sys-audio.policy:
  file.managed:
    - source: salt://appvms/sys-audio/files/30-sys-audio.policy
    - user: 1000
    - group: 1000
    - mode: "0640"
    - makedirs: true

{% endif %}
