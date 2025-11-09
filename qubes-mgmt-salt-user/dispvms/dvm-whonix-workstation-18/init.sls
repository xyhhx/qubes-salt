{%- set vm_name = 'dvm-whonix-workstation-18' -%}
{%- set template_name = 'on-whonix-workstation-18' -%}

{%- if grains.id == 'dom0' -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template: '{{ template_name }}'
      - label: red
      - netvm: 'sys-tor-whonix'
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
      - set:
        - gui-events-max-delay: 100
        - menu-items: {{ [

'Alacritty.desktop',
'anondist-torbrowser_update.desktop',
'janondisttorbrowser.desktop',
'systemcheck.desktop',
'thunar.desktop',

] | join(' ') }}
        - menu-favorites: '@disp:janondisttorbrowser.desktop anondist-torbrowser_update.desktop'
    - tags:
      - add:
        - anon-vm
        - sdwdate-gui-client

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
