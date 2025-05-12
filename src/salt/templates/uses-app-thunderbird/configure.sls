# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = 'templates.uses-app-thunderbird.configure' %}

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

{% import_json  "./files/policies.json" as user_policies %}

'{{ name }}':
  pkgrepo.managed:
    - name: dove
    - copr: celenity/copr
    - require_in:
      - pkg: '{{ name }}'
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
