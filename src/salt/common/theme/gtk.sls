# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set name = "common.theme.gtk" %}

'{{ name }}':
  pkg.installed:
    - pkgs:
{% if grains['os_family']|lower == 'debian' %}
      # There is no deepin GTK theme on debian
{% elif grains['os_family']|lower == 'redhat' %}
      - deepin-gtk-theme
{% endif %}
    - skip_suggestions: true
    - install_recommends: false
