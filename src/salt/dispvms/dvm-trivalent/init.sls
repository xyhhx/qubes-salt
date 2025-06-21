{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:dispvms:trivalent") -%}
{%- set template_name = salt["pillar.get"]("vm_names:templates:uses:trivalent") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template: '{{ template_name }}'
      - label: red
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
        - service.qubes-ctap-proxy
      - set:
        - menu-items: trivalent.desktop
        - menu-favorites: "@disp:trivalent"

{% endif %}
