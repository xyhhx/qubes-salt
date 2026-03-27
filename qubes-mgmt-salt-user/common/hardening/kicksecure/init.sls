{%- if salt['grains.get']('os_family') | lower == 'debian' -%}

include:
  - .install
  - .post-install
  - common.hardening.hardened-malloc.service

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}

