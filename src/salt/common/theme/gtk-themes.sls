
# vim: set ts=2 sw=2 sts=2 et :
---

{% if salt['pillar.get']('qubes:type') == 'template' %}

{%- set pkgs = salt['grains.filter_by']({
    'RedHat': [
      'adwaita-gtk2-theme',
      'deepin-gtk-theme'
      'flat-remix-gtk2-theme',
      'flat-remix-gtk3-theme',
      'flat-remix-gtk4-theme',
      'gnome-themes-extra',
      'greybird-light-theme',
      'materia-gtk-theme'
    ],
    'Debian': [
      'blackbird-gtk-theme',
      'gnome-themes-extra',
      'greybird-gtk-theme'
      'materia-gtk-theme',
      'numix-gtk-theme',
    ]
  },
  default='RedHat'
)
-%}

'common.theme.gtk-themes':
  pkg.installed:
    - pkgs: {{ pkgs }}

{% endif %}
