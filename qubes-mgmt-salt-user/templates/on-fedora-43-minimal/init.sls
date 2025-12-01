{%- set vm_name = "on-fedora-43-minimal" -%}
{%- set base_template = "fedora-43-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : 
