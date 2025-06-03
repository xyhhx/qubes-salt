# vim: set ts=2 sw=2 sts=2 et :

---

{% if grains.id != 'dom0' %}

include:
  - common.theme.fonts
  - common.theme.gtk-tweaks
  - common.theme.deepin
  - common.theme.dconf

{% endif %}
