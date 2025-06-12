{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:dispvms:librewolf") -%}
{%- set template_name = salt["pillar.get"]("vm_names:templates:uses:librewolf") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
        - service.qubes-ctap-proxy
      - set:
        - menu-items: librewolf.desktop
        - menu-favorites: "@disp:librewolf"

{% endif %}
