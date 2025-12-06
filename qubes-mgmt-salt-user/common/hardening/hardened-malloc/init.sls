{%- if grains.id != 'dom0' -%}

include:
  - .install
  - .service

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
