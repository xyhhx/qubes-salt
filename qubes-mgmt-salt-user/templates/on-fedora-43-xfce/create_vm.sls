{%- if grains.id == "dom0" -%}
{%- set vm_name = "on-fedora-44-xfce" -%}
{%- set base_template = "fedora-44-xfce" -%}

{%- from "utils/macros/create_templatevm.sls" import templatevm -%}
{{ templatevm(vm_name, base_template=base_template) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
