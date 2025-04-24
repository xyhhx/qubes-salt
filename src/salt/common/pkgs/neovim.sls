# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

{% set name = "common.pkgs.neovim" %}

# TODO: accomodate debian-based distros
{% if grains['os_family']|lower == 'redhat' %}

include:
  - common.https_proxy

neovim-nightly:
  pkgrepo.managed:
    - copr: agriffis/neovim-nightly

'{{ name }} - pkg.installed':
  pkg.installed:
    - pkgs:
      - neovim
      - python3-neovim

{% endif %}
{% endif %}

