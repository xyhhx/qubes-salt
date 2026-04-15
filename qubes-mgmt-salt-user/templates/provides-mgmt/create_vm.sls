{%- if grains.id == "dom0" -%}
{%- set vm_name = "provides-mgmt" -%}
{%- set base_template = "fedora-43-minimal" -%}

{%- load_yaml as options -%}
prefs:
  - audiovm: ""
  - management_dispvm: "dvm-fedora-43-xfce"
{%- endload -%}

{%- from "utils/macros/create_templatevm.sls" import templatevm -%}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
