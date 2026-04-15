{%- if grains.id == "dom0" -%}
{%- set vm_name = "provides-tor-whonix" -%}
{%- set base_template = "whonix-gateway-18" -%}

{%- load_yaml as options -%}
features:
  - disable:
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
