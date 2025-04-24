# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set vm_name = "dvm-trivalent" %}
{% if grains['id'] != 'dom0' %}

# TODO: configure trivalent

{% endif %}
