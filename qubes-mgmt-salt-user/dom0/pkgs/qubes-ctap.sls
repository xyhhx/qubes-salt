{%- if grains.id == 'dom0' -%}

qubes-ctap-dom0:
  pkg.installed:
    - install_recommends: false
    - skip_suggestions: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
