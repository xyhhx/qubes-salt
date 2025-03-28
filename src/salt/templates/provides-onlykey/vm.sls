# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% set vm_name = "provides-onlykey" %}
{% set base_template = 'fedora-41-minimal' %}

{% from 'utils.sls' import create_template with context %}
{{ create_template(vm_name, base_template) }}

'{{ vm_name }}':
  qvm.service:
    - enable:
      - updates-proxy-setup

