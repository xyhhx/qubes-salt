# vim: set ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

{% set name = "common.pkgs.neovim" %}

# TODO: accomodate debian-based distros
{% if grains.os_family|lower == 'redhat' %}

include:
  - common.https_proxy

{%- load_yaml as copr_repos -%}
  - atim/bottom
  - faramirza/gdu
  - atim/lazygit
  - agriffis/neovim-nightly
{%- endload -%}

{%- for repo in copr_repos %}
'{{ repo | regex_search('[^/]\+$)') }}':
  pkgrepo.managed:
    - copr: {{ repo }}

'{{ name }}':
  archive.extracted:
    - name: /usr/share/fonts/blex-mono-nerd-font
    - source:
      - https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/IBMPlexMono.tar.xz
      - salt://common/pkgs/files/IBMPlexMono.tar.xz
    - source_hash: sha512=36010442afaa0b226b36cac5145a087f5ec912c7f576c0c1e0e5c6e39cccef243ed444480a8db573f54e0b4fed4b55055a2b6a6309cfb8ad1477e8f0bd362ea3
    - source_hash_update: true
    - overwrite: true
    - enforce_toplevel: false
    - onlyif: |-
        [[ -z $(fc-list : family | grep 'BlexMono Nerd Font') ]]
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

