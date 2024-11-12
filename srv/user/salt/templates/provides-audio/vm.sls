# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---
{% set vm_name = pillar.names.templates.providers.audio %}
{% set base_template = 'fedora-40-minimal' %}

{% from 'utils.sls' import create_template with context %}
{{ create_template(vm_name, base_template) }}
