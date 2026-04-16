{%- if grains.id != "dom0" -%}
{%- from "utils/macros/macros.html" import set_papirus_icon_colors -%}

{%- set icon_color = salt["grains.filter_by"]({
  "dvm-fedora-43-xfce": "carbine",
  "dvm-fedora-43-xfce": "grey"
}, default="grey") -%}

{{ set_papirus_icon_colors(color=icon_color) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
