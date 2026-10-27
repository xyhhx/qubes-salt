{%- if grains.id == "dom0" -%}

{%-   set vm_name = "vault-pgp" -%}
{%-   from "utils/macros/managed_policy.sls" import managed_policy -%}
{%-   load_yaml as context -%}
vault_vm: "{{ vm_name }}"
{%-   endload -%}
{%-   load_yaml as defaults -%}
client_tag: "split-gpg2-client"
policy: "qubes.Gpg2"
server_tag: "split-gpg2-server"
vault_vm: "vault-pgp"
{%-   endload -%}

{{ managed_policy(policy_file, context, defaults) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
