{%- if grains.id == "dom0" -%}
{%- set vm_name = "app-qb" -%}
{%- from "./opts.jinja" import executor_dvm, vm, template_name -%}

"{{ slsdotpath }}:: {{ template_name }} exists":
  qvm.exists:
    - name: "{{ template_name }}"

"{{ slsdotpath }}:: {{ executor_dvm }} exists":
  qvm.exists:
    - name: "{{ executor_dvm }}"

"{{ vm_name }}":
  qvm.vm:
    - require:
      - qvm: "{{ slsdotpath }}:: {{ template_name }} exists"

    {{ vm | dict_to_sls_yaml_params | indent }}

"{{ slsdotpath }}:: extend private vol":
  cmd.run:
    - require:
      - qvm: "{{ vm_name }}"
    - name: |-
        qvm-volume resize {{ vm_name }}:private 32Gi
    - use_vt: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
