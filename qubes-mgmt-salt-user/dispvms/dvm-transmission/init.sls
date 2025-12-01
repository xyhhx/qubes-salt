{%- set vm_name = "dvm-transmission" -%}
{%- set template_name = "uses-app-transmission" -%}

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
        - service.hardened_malloc
      - set:
        - menu-items: transmission-gtk.desktop
        - menu-favorites: "@disp:transmission-gtk.desktop"

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
