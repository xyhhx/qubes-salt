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

"{{ slsdotpath }}:: install split-ssh policy":
  file.managed:
    - require:
      - qvm: "{{ vm_name }}"
    - name: "/usr/local/etc/qubes/policy.d/available/30-split-ssh.policy"
    - source: "salt://{{ tpldir | path_join("/files/split-ssh.policy.j2") }}"
    - template: "jinja"
    - user: root
    - group: qubes
    - mode: "0640"
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
    - name: "/usr/local/etc/qubes/policy.d/enabled/30-split-ssh.policy"
    - target: "/usr/local/etc/qubes/policy.d/available/30-split-ssh.policy"
    - makedirs: true
    - user: "root"
    - group: "qubes"
    - mode: "0777"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
