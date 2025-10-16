{%- if grains.os_family | lower == 'debian' -%}

include:
  - .prereqs
  - .install

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}

