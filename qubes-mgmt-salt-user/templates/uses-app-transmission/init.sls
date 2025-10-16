{%- set vm_name = "uses-app-transmission" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

'{{ slsdotpath }}:pkgs':
  pkg.installed:
    - pkgs:
      - deluge
      - qubes-core-agent-networking
      - transmission

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
