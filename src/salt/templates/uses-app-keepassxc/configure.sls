# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = 'templates.uses-app-keepassxc.configure' %}

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

keepassxc:
  pkg.installed:
    - aggregate: true


qrencode:
  pkg.installed:
    - aggregate: true


{% endif %}
