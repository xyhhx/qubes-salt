{%- if grains.id == "dom0" -%}
{%- set vm_name = "dvm-fetch" -%}
{%- from "utils/macros/managed_policy.sls" import managed_policy -%}
{%- set policy_file = "30-dvm-fetch.policy" -%}

{%- load_yaml as context -%}
vm_name: "{{ vm_name }}"
{%- endload -%}

{{ managed_policy(policy_file, context) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
