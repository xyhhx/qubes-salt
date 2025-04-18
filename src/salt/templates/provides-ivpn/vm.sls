# vim: set syntax=yaml ft=sls ts=2 sw=2 sts=2 et :

---
{% set vm_name = "provides-ivpn" %}
# {% set vm_name = pillar.names.templates.providers.ivpn %}
{% set base_template = 'fedora-41-minimal' %}

{% from 'utils/macros/create_template.sls' import create_template with context %}
{{ create_template(vm_name, base_template) }}
