{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---
{% if grains.id != 'dom0' %}

qubes-ctap:
  pkg.installed:
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
