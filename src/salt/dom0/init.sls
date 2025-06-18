{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id == 'dom0' %}

include:
  - .base-templates
  - .pkgs
  - .policies
  - .user-settings

{% endif %}
