{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:appvms:dino") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:uses:dino") -%}
{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: blue
    - features:
      - set:
        - menu-items: im.dino.Dino.desktop
        - menu-favorites: im.dino.Dino
    - require:
      - qvm: '{{ template }}'

{% endif %}
