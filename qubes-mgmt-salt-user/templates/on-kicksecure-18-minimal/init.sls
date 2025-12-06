{%- set vm_name = "on-kicksecure-18-minimal" -%}
{%- set base_template = "debian-13-minimal" -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
features:
  - disable:
    - selinux
tags:
  - add:
    - whonix-updatevm
    - on-kicksecure
{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{%- else -%}

include:
  - common.hardening.kicksecure

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
