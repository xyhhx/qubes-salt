{%- if grains.id == "dom0" -%}
{%- from "./opts.jinja" import vm, template -%}
{%- set vm_name = "app-thunderbird" -%}

"{{ vm_name }}":
  qvm.vm:

    {{ vm | dict_to_sls_yaml_params | indent }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
