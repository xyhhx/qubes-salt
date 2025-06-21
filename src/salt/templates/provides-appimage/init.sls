{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:appimage") -%}
{%- set base_template = salt["pillar.get"]("base_templates:fedora:minimal") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

fuse-libs:
  pkg.installed

{% endif %}
