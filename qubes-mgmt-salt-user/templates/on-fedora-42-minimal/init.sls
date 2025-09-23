{%- set vm_name = "on-fedora-42-minimal" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% endif %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
