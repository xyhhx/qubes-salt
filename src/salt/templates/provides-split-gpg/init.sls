# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.providers.split_gpg %}
{% set base_template = pillar.names.templates.base.fedora_minimal %}

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

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split
      - sequoia-sq
      - sequoia-chameleon-gnupg
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
