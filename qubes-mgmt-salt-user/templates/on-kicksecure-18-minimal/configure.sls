{%- if grains.id != "dom0" -%}

include:
  - common.hardening.kicksecure

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
