{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:os:debian", "on-debian-12-minimal") -%}
{%- set base_template = salt["pillar.get"]("base_templates:debian:minimal", "debian-12-minimal") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, options=vm_options, base_template=base_template) }}

{% endif %}
