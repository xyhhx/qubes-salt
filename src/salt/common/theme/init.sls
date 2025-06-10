# vim: set ts=2 sw=2 sts=2 et :

---

{% if grains.id != 'dom0' %}

include:
  - common.theme.fonts
  - common.theme.gtk-themes
  - common.theme.icon-themes
  - common.theme.win-10-darker
  - common.theme.config

{% endif %}
