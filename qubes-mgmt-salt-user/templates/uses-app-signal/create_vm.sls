{%- if grains.id == "dom0" -%}
{%- set vm_name = "uses-app-signal" -%}
{%- set base_template = "debian-13-minimal" -%}

{%- load_yaml as options -%}
features:
  - set:
    - default-menu-items: signal-desktop.desktop
  - disable:
    - service.hardened_malloc
    - selinux
tags:
  - add:
    - on-kicksecure
    - whonix-updatevm
{%- endload -%}

{%- from "utils/macros/create_templatevm.sls" import templatevm -%}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
