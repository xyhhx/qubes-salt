{%- set vm_name = 'app-senpai' -%}
{%- set template_name = 'uses-app-senpai' -%}
{%- set label = 'blue' -%}

{%- if grains.id == 'dom0' -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
    - prefs:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
    - features:
      - set:
        - menu-items: senpai.desktop

{%- endif -%}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
