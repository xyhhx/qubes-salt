{%- set vm_name = "dvm-firefox" -%}
{%- set template_name = "uses-app-firefox" -%}

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
      - disable:
        - service.hardened_malloc
      - enable:
        - appmenus-dispvm
        - service.qubes-ctap-proxy
      - set:
        - menu-items: org.mozilla.firefox.desktop
        - menu-favorites: "@disp:org.mozilla.firefox"

{% endif %}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
