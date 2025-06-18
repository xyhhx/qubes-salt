{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% macro templatevm(name, options={}, base_template="fedora-41-minimal") %}

{% import_yaml "./qvm_defaults.yml" as defaults %}

{% set vm = {} %}
{% do salt["defaults.merge"](vm, defaults, in_place=true) %}
{% do salt["defaults.merge"](vm, salt["pillar.get"]("qvm:defaults", default={}), in_place=true) %}
{% do salt["defaults.merge"](vm, options, in_place=true) %}

"{{ name }}":
  qvm.vm:

    - clone:
      - source: "{{ base_template }}"

    {{ vm | dict_to_sls_yaml_params | indent }}


{% endmacro %}

