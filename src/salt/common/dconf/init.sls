# vim: set ts=2 sw=2 sts=2 et :
---

{% if grains.id != 'dom0' %}

include:
  - common.dconf.setup

{% endif %}
