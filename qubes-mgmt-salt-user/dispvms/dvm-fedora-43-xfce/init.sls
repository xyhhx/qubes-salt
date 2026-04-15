{%- set vm_name = 'dvm-fedora-43-xfce' -%}
{%- set template_name = 'on-fedora-43-xfce' -%}

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
      - disable:
        - service.hardened_malloc
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: Alacritty.desktop thunar.desktop org.mozilla.desktop
        - menu-favorites: "@disp:Alacritty @disp:thunar @disp:org.mozilla.desktop"

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
      - disable:
        - service.hardened_malloc
      - enable:
        - appmenus-dispvm
      - set:
        - menu-items: Alacritty.desktop thunar.desktop
        - menu-favorites: "@disp:Alacritty @disp:thunar"

{%- else -%}

{%- from "utils/macros/macros.html" import set_papirus_icon_colors -%}

{%- if salt['grains.get']('id') == 'dvm-fedora-43-xfce' -%}
{{ set_papirus_icon_colors(color="carbine") }}
{%- elif salt['grains.get']('id') == 'dvm-fedora-43-xfce-offline' -%}
{{ set_papirus_icon_colors(color="grey") }}
{%- endif -%}

{%- endif -%}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
