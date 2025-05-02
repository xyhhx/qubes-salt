# vim: set ts=2 sw=2 sts=2 et :

---
{% set name = "common.theme.gtk" %}

{% if grains.os_family|lower == 'redhat' %}
deepin-gtk-theme:
  pkg.installed:
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true
{% endif %}

/etc/gtk-3.0/settings.ini:
  file.managed:
    - source: salt://common/theme/files/gtk3-settings.ini
    - makedirs: true
    - user: root
    - group: root
    - mode: '0640'
