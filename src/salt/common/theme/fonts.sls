# vim: set ts=2 sw=2 sts=2 et :
---

{%- set pkgs = salt['grains.filter_by']({
    'Debian': [
      'fonts-cascadia-code',
      'fonts-fantasque-sans',
      'fonts-ibm-plex',
      'fonts-inter',
      'fonts-inter-variable',
      'fonts-liberation2',
      'fonts-noto',
      'fonts-noto-color-emoji'
    ],
    'RedHat': [
      'cascadia-fonts-all',
      'google-noto-color-emoji-fonts',
      'google-noto-fonts-all',
      'ibm-plex-fonts-all',
      'liberation-fonts-all',
      'rsms-inter-fonts'
    ]
  },
  default='RedHat'
)
-%}

{% set name = "common.theme.fonts" %}
{% if salt['pillar.get']('qubes:type') in ['admin', 'template'] %}

'{{ name }}':
  pkg.installed:
    - pkgs: {{ pkgs }}

{% endif %}
