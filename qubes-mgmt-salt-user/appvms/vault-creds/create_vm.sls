{%- if grains.id == "dom0" -%}
{%- set vm_name = "vault-creds" -%}
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
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
