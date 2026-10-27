{% if grains.id == "dom0" %}

{%- from "utils/macros/managed_policy.sls" import managed_policy -%}
{%- set policy_file = "30-whonix.policy" -%}
{%- load_yaml as context -%}
gateway_vm: "{{ vm_name }}"
{%- endload -%}

{{ managed_policy(policy_file, context) }}

{% endif %}
# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
