{%- set vm_name = 'app-element' -%}
{%- set template_name = 'uses-app-element' -%}
{%- set label = 'green' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
    - prefs:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
      - memory: 2000
      - maxmem: 4000
      - vcpus: 2
    - features:
      - menu-items: element-desktop.desktop element-nightly-desktop.desktop

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
