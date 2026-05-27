{%- if grains.id != "dom0" -%}

{%- from "utils/macros/set_papirus_icon_colors.sls" import set_papirus_icon_colors -%}
{{ set_papirus_icon_colors(color="black") }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
