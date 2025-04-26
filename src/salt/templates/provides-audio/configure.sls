# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = 'templates.provides-audio.configure' %}
# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

{% endif %}
