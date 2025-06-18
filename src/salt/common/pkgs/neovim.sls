{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

{%- set name = "common.pkgs.neovim" -%}

# TODO: accomodate debian-based distros
{% if grains.os_family | lower == 'redhat' %}

include:
  - common.https_proxy

'{{ name }}':
  pkgrepo.managed:
    - names:
      - bottom:
        - copr: atim/bottom
      - gdu:
        - copr: faramirza/gdu
      - lazygit:
        - copr: atim/lazygit
      - neovim-nightly:
        - copr: agriffis/neovim-nightly
  archive.extracted:
    - name: /usr/share/fonts/blex-mono-nerd-font
    - source:
      - salt://common/pkgs/files/IBMPlexMono.tar.xz
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

