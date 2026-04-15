{%- if grains.id == 'dom0' -%}
{%- set vm_name = 'sys-vpn-ivpn' -%}
{%- set template_name = 'provides-vpn-ivpn' -%}

{%- from "./opts.jinja" import vm -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: yellow

    {{ vm | dict_to_sls_yaml_params | indent }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
