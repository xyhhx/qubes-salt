{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---

{% set name = "dom0.pkgs" %}
{% set user = salt["pillar.get"]("config.dom0_user") %}

{% if grains.id == 'dom0' %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - qubes-ctap-dom0
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
