{%- if grains.id != "dom0" -%}

include:
  - common.xfce4-helpers

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - fuse
      - fuse-libs
      - qubes-core-agent-networking
      - Thunar
    - install_recommends: false
    - skip_suggestions: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
