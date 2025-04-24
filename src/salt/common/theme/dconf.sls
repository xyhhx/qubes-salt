# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = 'common.theme.dconf' %}
{% set dconf_d = '/etc/dconf/db/local.d' %}

'{{ name }}':
  file.managed:
    - user: 1000
    - group: 1000
    - mode: '0640'
    - names:
      - '{{ dconf_d }}/gtk-theme':
        - source: salt://common/theme/files/gtk-theme.conf
        - context:
          gtk_theme: 'deepin'
      - '{{ dconf_d }}/prefer-dark':
        - source: salt://common/theme/files/prefer-dark.conf
