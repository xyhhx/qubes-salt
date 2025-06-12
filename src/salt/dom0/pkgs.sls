{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set user = salt["pillar.get"]("opts:dom0_user") -%}

{% if grains.id == 'dom0' %}

qubes-ctap-dom0:
  pkg.installed:
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
