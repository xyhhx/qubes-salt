# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = "common.pkgs.base" %}

{% if grains.id != 'dom0' %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - curl
      - xclip
{% if grains.os_family|lower == 'debian' %}
      - vim
{% elif grains.os_family|lower == 'redhat' %}
      - vim-common
{% endif %}
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
