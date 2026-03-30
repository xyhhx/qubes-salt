{%- if grains.id == "dom0" -%}

{%- set vm_name = "uses-app-tuta" -%}
{%- set base_template = "fedora-43-minimal" -%}

{%- from "./opts.jinja" import vm_options -%}
{%- from "utils/macros/create_templatevm.sls" import templatevm -%}

{{ templatevm(vm_name, base_template=base_template, options=vm_options) }}

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
