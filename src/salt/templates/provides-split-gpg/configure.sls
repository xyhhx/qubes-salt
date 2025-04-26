# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

# Set vm_name from pillar data
{% set vm_name = 'provides-split-gpg' %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
