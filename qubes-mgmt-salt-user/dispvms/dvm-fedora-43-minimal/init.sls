{%- set vm_name = 'dvm-fedora-43-minimal' -%}
{%- set template_name = 'on-fedora-43-minimal' -%}

{%- if grains.id == 'dom0' -%}

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
      - set:
        - menu-items: Alacritty.desktop
        - menu-favorites: "@disp:Alacritty"

'{{ vm_name }}-offline':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: gray
    - prefs:
      - template: '{{ template_name }}'
      - label: gray
      - netvm: ''
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: Alacritty.desktop
        - menu-favorites: "@disp:Alacritty"

{%- endif -%}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
