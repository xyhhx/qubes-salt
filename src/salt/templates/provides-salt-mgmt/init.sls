{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:salt_mgmt") -%}
{%- set base_template = salt["pillar.get"]("base_templates:fedora:minimal") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - present:
      - label: gray
    - prefs:
      - label: gray
      - audiovm: ""
      - netvm: ""
      - memory: 300
      - maxmem: 600
      - vcpus: 1
      - include_in_backups: False
    - features:
      - set:
        - menu-items: Alacritty.desktop
        - default-menu-items: Alacritty.desktop
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41

{% else %}

{%- load_yaml as pkgs %}
- salt
- salt-minion
- qubes-mgmt-salt-config
- qubes-mgmt-salt-base-overrides
- qubes-mgmt-salt-base-overrides-libs
- qubes-mgmt-salt-base-topd
- qubes-mgmt-salt-base-config
- qubes-mgmt-salt-base
- qubes-mgmt-salt
{% endload -%}

{% for pkg in pkgs %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% endif %}
