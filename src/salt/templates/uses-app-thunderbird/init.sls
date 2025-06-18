{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:uses:thunderbird", "uses-app-thunderbird") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

{% import_json  "./files/policies.json" as user_policies %}

'{{ vm_name }}':
  pkgrepo.managed:
    - name: dove
    - copr: celenity/copr
    - require_in:
      - pkg: '{{ vm_name }}'
  pkg.installed:
    - pkgs:
      - dove
      - thunderbird
      - thunderbird-qubes
  file.serialize:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - serializer: json
    - deserializer: json
    - merge_if_exists: true
    - show_changes: true
    - name: /etc/thunderbird/policies/policies.json
    - dataset: {{ user_policies }}

{% endif %}
