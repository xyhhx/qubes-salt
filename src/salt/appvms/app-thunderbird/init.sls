{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:appvms:thunderbird") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:uses:thunderbird") -%}
{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: blue
    - features:
      - set:
        - menu-items: net.thunderbird.Thunderbird.desktop
        - menu-favorites: "net.thunderbird.Thunderbird"
    - require:
      - qvm: '{{ template }}'

{% endif %}
