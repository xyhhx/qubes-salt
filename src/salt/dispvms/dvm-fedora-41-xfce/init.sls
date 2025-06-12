{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}


{%- set vm_name = salt["pillar.get"]("vm_names:dispvms:fedora_xfce") -%}
{%- set template_name = salt["pillar.get"]("vm_names:templates:os:fedora_xfce") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template-for-dispvms: true
    - features:
      - set:
        - menu-favorites: "@disp:org.mozilla.firefox @disp:thunar @disp:xfce4-terminal"

'{{ vm_name }}-offline':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: gray
    - prefs:
      - template-for-dispvms: true
    - features:
      - set:
        - menu-favorites: "@disp:thunar @disp:xfce4-terminal"

{% endif %}

