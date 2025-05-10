# vim: set ts=2 sw=2 sts=2 et :
---

{% if grains.id == 'dom0' %}

include:
  - dom0.base-templates
  - dom0.pkgs
  - dom0.policies
  - dom0.user-settings

{% endif %}
