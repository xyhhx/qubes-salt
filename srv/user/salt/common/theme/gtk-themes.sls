# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---
'common.theme - dependencies':
  pkg.installed:
    - pkgs:
{% if grains['os_family']|lower == 'debian' %}
      # There is no deepin GTK theme on debian
{% if grains['os_family']|lower == 'redhat' %}
      - deepin-gtk-theme
{% endif %}
    - skip_suggestions: true
    - install_recommends: false

