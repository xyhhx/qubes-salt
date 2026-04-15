{%- if grains.id != "dom0" -%}

include:
  - common.xfce4-helpers

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - libreoffice
      - Thunar
      - thunar-archive-plugin
      - qubes-core-agent-thunar

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
