# vim: set ts=2 sw=2 sts=2 et :

---
{% set name = "common.theme.icons" %}

{% if grains.id != 'dom0' %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - deepin-icon-theme
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true

{% endif %}
