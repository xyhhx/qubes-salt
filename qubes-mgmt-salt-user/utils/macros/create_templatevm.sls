{%- macro templatevm(name, options={}, base_template="fedora-43-minimal") -%}

{%- from "common/defaults/qvm_defaults.jinja" import templatevm_defaults -%}

{#- These remain after cloning the base templates, so they have to be removed -#}
{%- load_yaml as disable_lock_features -%}
features:
  - disable:
    - prohibit-start
    - skip-update
{%- endload -%}

{%- set vm = {} -%}
{%- do salt["defaults.merge"](vm, templatevm_defaults, merge_lists=true, in_place=true) -%}
{%- do salt["defaults.merge"](vm, salt["pillar.get"]("qvm_defaults", default={}), merge_lists=true, in_place=true) -%}
{%- do salt["defaults.merge"](vm, options, merge_lists=true, in_place=true) -%}
{%- do salt["defaults.merge"](vm, disable_lock_features, merge_lists=true, in_place=true) -%}

"{{ slsdotpath }}.{{ sls }}:qvm.template_installed":
  qvm.template_installed:
    - name: "{{ base_template }}"

"{{ name }}":
  qvm.vm:
    - order: 1
    - require:
      - qvm: '{{ slsdotpath }}.{{ sls }}:qvm.template_installed'

    - clone:
      - source: "{{ base_template }}"

    {{ vm | dict_to_sls_yaml_params | indent }}

{%- endmacro -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
