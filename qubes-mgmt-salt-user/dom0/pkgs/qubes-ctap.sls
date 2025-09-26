{%- if grains.id == 'dom0' -%}
qubes-ctap-dom0:
  pkg.installed:
    - install_recommends: false
    - skip_suggestions: true
{%- endif -%}
