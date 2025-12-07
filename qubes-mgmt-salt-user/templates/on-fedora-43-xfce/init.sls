{%- set vm_name = "on-fedora-43-xfce" -%}
{%- set base_template = "fedora-43-xfce" -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
features:
  - disable:
    - service.hardened_malloc
{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{% else %}

{% from "utils/macros/set_papirus_icon_colors.sls" import set_papirus_icon_colors %}
{{ set_papirus_icon_colors(color="black") }}

{% endif %}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
