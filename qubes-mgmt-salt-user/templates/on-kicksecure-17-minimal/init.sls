{%- set vm_name = "on-kicksecure-17-minimal" -%}
{%- set base_template = "debian-12-minimal" -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
features:
  - set:
    - selinux: 0
tags:
  - add:
    - whonix-updatevm
    - on-kicksecure
{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
