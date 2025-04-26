# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

{% set name = "common.pkgs.neovim" %}

# TODO: accomodate debian-based distros
{% if grains.os_family|lower == 'redhat' %}

include:
  - common.https_proxy

bottom:
  pkgrepo.managed:
    - copr: atim/bottom

gdu:
  pkgrepo.managed:
    - copr: faramirza/gdu

lazygit:
  pkgrepo.managed:
    - copr: atim/lazygit

neovim-nightly:
  pkgrepo.managed:
    - copr: agriffis/neovim-nightly

/usr/share/fonts/blex-mono-nerd-font:
  archive.extracted:
    - source:
      - https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/IBMPlexMono.tar.xz
      - salt://common/pkgs/files/IBMPlexMono.tar.xz
    - source_hash: sha512=36010442afaa0b226b36cac5145a087f5ec912c7f576c0c1e0e5c6e39cccef243ed444480a8db573f54e0b4fed4b55055a2b6a6309cfb8ad1477e8f0bd362ea3
    - source_hash_update: true
    - overwrite: true
    - enforce_toplevel: false
    - onlyif: |-
        [[ -z $(fc-list : family | grep 'BlexMono Nerd Font') ]]

'{{ name }} - pkg.installed':
  pkg.installed:
    - pkgs:
      - bottom
      - gdu
      - lazygit
      - neovim
      - python3-neovim
      - ripgrep
      - tree-sitter-cli

{% endif %}
{% endif %}

