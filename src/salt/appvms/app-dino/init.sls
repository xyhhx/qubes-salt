{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:appvms:dino", "app-dino") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:uses:dino", "uses-app-dino") -%}
{% if grains.id == 'dom0' %}

include:
  - templates.{{ template }}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: blue
    - prefs:
      - template: '{{ template }}'
      - label: blue
    - features:
      - set:
        - menu-items: im.dino.Dino.desktop
        - menu-favorites: im.dino.Dino
    - require:
      - sls: templates.{{ template }}

{% endif %}
