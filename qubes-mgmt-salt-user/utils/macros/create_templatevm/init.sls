{% macro templatevm(name, options={}, base_template="fedora-42-minimal") %}

{%- from './map.jinja' import vm with context -%}

"{{ sls }}:{{ name }}:qvm.template_installed":
  qvm.template_installed:
    - name: "{{ base_template }}"

"{{ name }}":
  qvm.vm:

    - clone:
      - source: "{{ base_template }}"

    {{ vm | dict_to_sls_yaml_params | indent }}

{% endmacro %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
