{%- if grains.id == "dom0" -%}

{%- from "utils/macros/managed_policy.sls" import managed_policy -%}
{%- set vm_name = "disp-sys-usb" -%}
{%- set policy_file = "30-dispvm-usb-input.policy" -%}

{%- load_yaml as context -%}
usb_qube: "{{ vm_name }}"
keyboard_policy: "qubes.InputKeyboard"
keyboard_policy_action: "ask"
mouse_policy: "qubes.InputMouse"
mouse_policy_action: "ask"
tablet_policy: "qubes.InputTablet"
tablet_policy_action: "deny"
{%- endload -%}

{{ managed_policy(policy_file, context) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
