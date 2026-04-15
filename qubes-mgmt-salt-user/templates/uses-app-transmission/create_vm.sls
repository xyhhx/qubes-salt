{%- if grains.id == "dom0" -%}
{%- set vm_name = "uses-app-transmission" -%}
{%- set base_template = "fedora-43-minimal" -%}


{%- from "utils/macros/create_templatevm.sls" import templatevm -%}
{{ templatevm(vm_name, base_template=base_template) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
