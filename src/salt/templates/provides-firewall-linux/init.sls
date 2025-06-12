{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}


{% set name = "templates.provides-firewall-linux.init" %}
{% set vm_name = salt["pillar.get"]("vm_names:templates:providers:firewall_linux") %}
{% set base_template = 'fedora-41-minimal' %}

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
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - iproute
      - qubes-core-agent-dom0-updates
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
