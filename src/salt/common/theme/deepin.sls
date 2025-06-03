
# vim: set ts=2 sw=2 sts=2 et :
---

{%- set pkgs = salt['grains.filter_by']({
  'RedHat': [
    'deepin-icon-theme',
    'deepin-gtk-theme'
  ]
}) 
-%}

'common.theme.deepin':
  pkg.installed:
    - pkgs: {{ pkgs }}
