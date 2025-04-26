# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

{% set name = "common.pkgs.rustup" %}

# TODO: accomodate debian-based distros
{% if grains.os_family|lower == 'redhat' %}

include:
  - common.https_proxy

rustup:
  pkg.installed

'rustup-init -yq':
  cmd.run

{% endif %}
{% endif %}


