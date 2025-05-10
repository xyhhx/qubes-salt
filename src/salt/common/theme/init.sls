# vim: set ts=2 sw=2 sts=2 et :

---

{% if grains.id != 'dom0' %}

include:
  - common.theme.fonts
  - common.theme.gtk
  - common.theme.icons
  - common.theme.dconf

{% endif %}
