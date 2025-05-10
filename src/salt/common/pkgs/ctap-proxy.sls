# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = "common.pkgs.ctap-proxy" %}
{% if grains.id != 'dom0' %}


'{{ name }}':
  pkg.installed:
    - pkgs:
      - qubes-ctap
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true

{% endif %}
