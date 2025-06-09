# vim: set ts=2 sw=2 sts=2 et :
---

{% if grains.id == 'dom0' or salt['pillar.get']('qubes:type') == 'template' %}
{#

{%- set xresources = salt['grains.filter_by'](
    {
      'RedHat': '/etc/X11/Xresources',
      'Debian': '/etc/X11/Xresources/x11-common'
    },
    default = 'RedHat'
  )
%}

'{{ xresources }}':
  file.keyvalue:
    - key: 'Xft.dpi'
    - value: {{ '192' if grains.id == 'dom0' else '96' }}
    - separator: ': '
    - append_if_not_found: true
#}

{% endif %}
