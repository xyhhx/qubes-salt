
# vim: set ts=2 sw=2 sts=2 et :
---

{% if salt['pillar.get']('qubes:type') == 'template' %}

{%- set pkgs = salt['grains.filter_by']({
    'RedHat': [
      'adwaita-icon-theme',
      'breeze-icon-theme',
      'breeze-icon-theme-fedora',
      'deepin-icon-theme',
      'elementary-icon-theme',
      'elementary-xfce-icon-theme',
      'flat-remix-icon-theme',
      'numix-icon-theme',
      'oxygen-icon-theme',
      'paper-icon-theme',
      'paper-icon-theme-dark',
      'paper-icon-theme-light'
    ],
    'Debian': [
      'adwaita-icon-theme',
      'breeze-icon-theme',
      'deepin-icon-theme',
      'elementary-icon-theme',
      'elementary-xfce-icon-theme',
      'numix-icon-theme',
      'oxygen-icon-theme',
      'paper-icon-theme'
    ]
  },
  default='RedHat'
)
-%}

'common.theme.icon-themes':
  pkg.installed:
    - pkgs: {{ pkgs }}

{% endif %}
