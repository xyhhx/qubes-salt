# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% if grains.id != 'dom0' %}
{% set vm_name = 'provides-split-gpg' %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split
      - sequoia-sq
      - sequoia-chameleon-gnupg
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true

{% endif %}
