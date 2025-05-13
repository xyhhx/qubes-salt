# vim: set ts=2 sw=2 sts=2 et sts :

---
{% set vm_name = "provides-appimage" %}

{% if grains.id != 'dom0' %}

fuse-libs:
  pkg.installed

{% endif %}
