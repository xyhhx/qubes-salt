{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set name = 'templates.uses-app-thunderbird.configure' -%}
{%- set vm_name = salt["pillar.get"]("vm_names:templates:uses:thunderbird") -%}
{%- set base_template = salt["pillar.get"]("base_templates:fedora:minimal") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41
        - uses-app
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

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
