# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

# Set vm_name from pillar data
{% set vm_name = pillar.names.templates.providers.usb %}


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
