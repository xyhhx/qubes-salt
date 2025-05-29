# vim: set ts=2 sw=2 sts=2 et :

---
{% set name = "common.theme.fonts" %}
{% if grains.id != 'dom0' %}

'{{ name }}':
  pkg.installed:
    - pkgs:
{% if grains.os_family|lower == 'debian' %}
      - fonts-fantasque-sans
      - fonts-ibm-plex
      - fonts-inter
      - fonts-inter-variable
      - fonts-liberation2
      - fonts-noto
      - fonts-noto-color-emoji
{% elif grains.os_family|lower == 'redhat' %}
      - cascadia-fonts-all
      - google-noto-color-emoji-fonts
      - google-noto-fonts-all
      - ibm-plex-fonts-all
      - liberation-fonts-all
      - rsms-inter-fonts
{% endif %}
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
