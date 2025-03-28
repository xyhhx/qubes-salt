# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.dispvms.browsers_fedora %}
{% if grains['id'] == 'dom0' %}

# noop

{% endif %}
