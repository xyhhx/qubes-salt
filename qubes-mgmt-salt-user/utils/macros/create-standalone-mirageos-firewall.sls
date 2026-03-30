{%- macro create_standalone_mirageos_firewall(name, netvm, version=None, vm_options={}) -%}
{%- if grains.id == 'dom0' -%}

{%- import_yaml "../../templates/provides-firewall-mirageos/defaults.yaml" as mirage_defaults -%}

{%- if version -%}
{%-   set mirage_version = version -%}
{%- else -%}
{%-   set mirage_version = mirage_defaults.mirageos_release.version -%}
{%- endif -%}

{#- patch a few things from the template defaults -#}
{%- load_yaml as defaults -%}
present:
  - label: "yellow"
prefs:
  - label: "yellow"
{%- endload -%}

{#- enforce a few settings -#}
{%- load_yaml as overrides -%}
present:
  - class: "StandaloneVM"
prefs:
  - kernel: 'mirage-firewall-{{ mirage_version }}'
  - provides-networking: true
{%- endload -%}

{%- set vm = {} -%}

{%- do salt["defaults.merge"](vm, mirage_defaults.vm, merge_lists=true, in_place=true) -%}
{%- do salt["defaults.merge"](vm, defaults, merge_lists=true, in_place=true) -%}
{%- do salt["defaults.merge"](vm, vm_options, merge_lists=true,in_place=true) -%}
{%- do salt["defaults.merge"](vm, overrides, merge_lists=true, in_place=true) -%}

'{{ name }}':
  qvm.vm:
    {{ vm | dict_to_sls_yaml_params | indent }}

{%- endif -%}
{%- endmacro -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
