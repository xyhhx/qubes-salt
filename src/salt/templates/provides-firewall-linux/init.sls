{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set name = "templates.provides-firewall-linux.init" -%}
{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:firewall_linux") -%}
{%- set base_template = salt["pillar.get"]("base_templates:fedora:minimal") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - iproute
      - qubes-core-agent-dom0-updates
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
