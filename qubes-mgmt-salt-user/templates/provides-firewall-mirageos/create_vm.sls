{%- if grains.id == 'dom0' -%}
{%- set vm_name = "provides-firewall-mirageos" -%}

{%- from './opts.jinja' import mirage_dest_dir, vm_options -%}

{%- set vm = {} -%}
{%- do salt["defaults.merge"](vm, vm_options, merge_lists=true, in_place=true) -%}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: "TemplateVM"
    - onlyif:
      - fun: file.file_exists
        args:
          - '{{ mirage_dest_dir | path_join("vmlinuz") }}'

    {{ vm | dict_to_sls_yaml_params | indent }}

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
