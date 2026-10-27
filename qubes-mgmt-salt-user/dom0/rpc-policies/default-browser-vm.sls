{%- if grains.id == "dom0" -%}

{%- from "utils/user_info.jinja" import user with context -%}
{%- from "utils/macros/managed_policy.sls" import managed_policy -%}
{%- set policy_file = "30-default-browser-vm.policy" -%}
{%- set browser_vm = salt["pillar.get"]("user_qubes:browser_vm", default="dvm-trivalent") -%}

{%- load_yaml as context -%}
browser_vm: "{{ browser_vm }}"
{%- endload -%}

{{ managed_policy(policy_file, context) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et tw& : -#}

