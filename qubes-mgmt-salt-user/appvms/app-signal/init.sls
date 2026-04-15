{%- set vm_name = 'app-signal' -%}
{%- set template_name = 'uses-app-signal' -%}
{%- set label = 'blue' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
    - prefs:
      - template: '{{ template_name }}'
      - label: '{{ label }}'
      - netvm: 'sys-tor-whonix'
      - memory: 2000
      - maxmem: 4000
      - vcpus: 2
    - features:
      - set:
        - menu-items: signal-desktop.desktop

{% endif %}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
