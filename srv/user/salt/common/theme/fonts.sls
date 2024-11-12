# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'common.theme - dependencies':
  pkg.installed:
    - pkgs:
{% if grains['os_family']|lower == 'debian' %}
      - fonts-fantasque-sans
      - fonts-ibm-plex
      - fonts-inter
      - fonts-liberation2
      - fonts-noto
{% if grains['os_family']|lower == 'redhat' %}
      - google-noto-*-fonts
      - ibm-plex-mono-fonts
      - liberation-fonts
      - rsms-inter-fonts
{% endif %}
    - skip_suggestions: true
    - install_recommends: false
