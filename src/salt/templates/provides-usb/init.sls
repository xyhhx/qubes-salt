# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.templates.providers.usb %}
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

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - gnome-keyring
      - qubes-usb-proxy
      - qubes-input-proxy-sender
      - qubes-ctap
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
