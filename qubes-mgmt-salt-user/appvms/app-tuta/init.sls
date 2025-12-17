{%- set vm_name = "app-tuta" -%}
{%- set template_name = "uses-app-tuta" -%}

{% if grains.id == 'dom0' %}

{%- set vm_label = 'blue' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: '{{ vm_label }}'
    - prefs:
      - template: '{{ template_name }}'
      - label: '{{ vm_label }}'
      - netvm: 'sys-tor-whonix'
    - features:
      - set:
        - menu-items: Alacritty.desktop tutanota-desktop.desktop
        - menu-favorites: tutanota-desktop

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
