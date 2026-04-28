{%- if grains.id == "dom0" -%}
{%- set vm_name = "vault-pgp" -%}
{%- from "./opts.jinja" import vm, template_name -%}

"{{ slsdotpath }}:: {{ template_name }} exists":
  qvm.exists:
    - name: "{{ template_name }}"

"{{ vm_name }}":
  qvm.vm:
    - require:
      - qvm: "{{ slsdotpath }}:: {{ template_name }} exists"

    {{ vm | dict_to_sls_yaml_params | indent }}

"{{ slsdotpath }}:: install policy":
  file.managed:
    - require:
      - qvm: "{{ vm_name }}"
    - name: "/usr/local/etc/qubes/policy.d/available/30-split-gpg2.policy"
    - source: "salt://{{ tpldir | path_join("files/split-gpg2.policy.j2") }}"
    - template: "jinja"
    - replace: true
    - user: "root"
    - group: "qubes"
    - mode: "0640"
    - makedirs: true
    - defaults:
        client_tag: "split-gpg2-client"
        policy: "qubes.Gpg2"
        server_tag: "split-gpg2-server"
        vault_vm: "vault-pgp"
    - context:
        vault_vm: "{{ vm_name }}"

"{{ slsdotpath }}:: enable policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install policy"
    - name: "/usr/local/etc/qubes/policy.d/enabled/30-split-gpg2.policy"
    - target: "/usr/local/etc/qubes/policy.d/available/30-split-gpg2.policy"
    - user: "root"
    - group: "qubes"
    - mode: "0640"
    - makedirs: true


{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
