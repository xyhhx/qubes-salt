# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = 'common.dconf.setup' %}
{% set dconf_d = '/etc/dconf/db/local.d' %}

'{{ name }}':
  file.managed:
    - user: 1000
    - group: 1000
    - mode: '0640'
    - makedirs: true
    - onchanges_in:
      - cmd
    - names:
      - '{{ dconf_d }}/touchpad':
        - source: salt://common/dconf/files/touchpad.conf
      - '{{ dconf_d }}/disable-automount':
        - source: salt://common/dconf/files/disable-automount.conf
      - '{{ dconf_d }}/locks/disable-automount':
        - source: salt://common/dconf/files/disable-automount.lock
  cmd.run:
    - name: dconf update
