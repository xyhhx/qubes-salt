{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - deluge
      - qubes-core-agent-networking
      - transmission

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
