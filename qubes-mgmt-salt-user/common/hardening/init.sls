{%- if salt['pillar.get']('qubes:type') == 'template' -%}

include:
  - .dconf
  - .hardened-malloc # Not all apps support hardened_malloc (firefox et al)
  - .homedirs
  - .kmods
  - .misc
  - .services
  - .ssh
  - .sysctl

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
