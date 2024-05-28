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
{% endif %}
    - skip_suggestions: true
    - install_recommends: false

/etc/fonts/local.conf:
  file.managed:
    - source: salt://common/theme/files/local.conf
