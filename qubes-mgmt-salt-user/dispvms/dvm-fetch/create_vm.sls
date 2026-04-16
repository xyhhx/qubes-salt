{%- if grains.id == "dom0" -%}
{%- set vm_name = "dvm-fetch" -%}
{%- from "./opts.jinja" import vm, template_name -%}
{%- set policy_dir = "/usr/local/etc/qubes/policy.d" -%}
{%- set policy_file = "30-dvm-fetch.policy" -%}

"{{ template_name }}:: exists":
  qvm.exists:
    - name: "{{ template_name }}"

"{{ vm_name }}":
  qvm.vm:
    - require:
      - qvm: "{{ template_name }}:: exists"

    {{ vm | dict_to_sls_yaml_params | indent }}

"{{ slsdotpath }}:: install policy":
  file.managed:
    - require:
      - qvm: "{{ vm_name }}"
    - name: "{{ policy_dir | path_join("available", policy_file) }}"
    - source: "salt://{{ tpldir | path_join("files/dom0", policy_dir, policy_file ~ ".j2") }}"
    - template: "jinja"
    - user: "root"
    - group: "root"
    - mode: "0640"
    - context:
        vm_name: vm_name

"{{ slsdotpath }}:: enable policy":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: install policy"
    - name: "{{ policy_dir | path_join("enabled", policy_file) }}"
    - target: "{{ policy_dir | path_join("available", policy_file) }}"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
