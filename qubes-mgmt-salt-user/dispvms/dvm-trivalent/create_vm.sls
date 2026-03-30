{%- if grains.id == "dom0" -%}
{%- set vm_name = "dvm-trivalent" -%}
{%- set template_name = "uses-app-trivalent" -%}

"{{ vm_name }}":
  qvm.vm:
    - present:
      - template: "{{ template_name }}"
      - label: "red"
    - prefs:
      - template: "{{ template_name }}"
      - label: "red"
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
        - service.qubes-ctap-proxy
      - set:
        - menu-items: trivalent.desktop
        - menu-favorites: "@disp:trivalent"

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
