{%- if grains.id == "dom0" -%}
{%- set vm_name = "vault-ssh" -%}
{%- from "./opts.jinja" import vm, template_name -%}

"{{ slsdotpath }}:: {{ template_name }} exists":
  qvm.exists:
    - name: "{{ template_name }}"

"{{ vm_name }}":
  qvm.vm:
    - require:
      - qvm: "{{ slsdotpath }}:: {{ template_name }} exists"

    {{ vm | dict_to_sls_yaml_params | indent }}

{%- endif -%}

{%- set policy_dir = "/usr/local/etc/qubes/policy.d" -%}
{%- set policy_file = "30-split-ssh.policy" -%}

"{{ slsdotpath }}:: install split-ssh policy":
  file.managed:
    - require:
      - qvm: "{{ vm_name }}"
    - name: "{{ policy_dir | path_join("available", policy_file) }}"
    - source: "salt://{{ tpldir | path_join("/files/dom0", policy_dir, policy_file ~ ".j2") }}"
    - template: "jinja"
    - user: "root"
    - group: "qubes"
    - mode: "0660"
    - makedirs: true
    - replace: true
    - defaults:
        client_tag: "split-ssh-client"
        policy: "qubes.SshAgent"
        server_tag: "split-ssh-server"
        vault_vm: "vault-ssh"
    - context:
        vault_vm: "{{ vm_name }}"

"{{ slsdotpath }}:: enable split-ssh policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install split-ssh policy"
    - name: "{{ policy_dir | path_join("enabled", policy_file) }}"
    - target: "{{ policy_dir | path_join("available", policy_file) }}"
    - makedirs: true
    - user: "root"
    - group: "qubes"
    - mode: "0777"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
