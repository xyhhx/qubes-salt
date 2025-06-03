# vim: set ts=2 sw=2 sts=2 et :
---

{% if salt['pillar.get']('qubes:type') == 'template' %}

/etc/gtk-3.0/settings.ini:
  file.managed:
    - source: salt://common/theme/files/gtk3-settings.ini
    - makedirs: true
    - user: root
    - group: root
    - mode: '0640'

{% endif %}
