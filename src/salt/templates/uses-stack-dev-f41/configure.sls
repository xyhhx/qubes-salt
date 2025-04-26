# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

{% set vm_name = 'uses-stack-dev-f41' %}
{% set name = 'templates.uses-stack-dev-f41.configure' %}

bat-extras:
  pkgrepo.managed:
    - copr: awood/bat-extras

'{{ name }}':
  pkg.installed:
    - pkgs:
      - bat
      - bat-extras
      - bind-utils
      - bottom
      - btop
      - cargo
      - clippy
      - direnv
      - fd-find
      - git
      - git-delta
      - iputils
      - jq
      - lazygit
      - lua
      - luarocks
      - nmap
      - opentofu
      - pipx
      - podman
      - psutils
      - python3-pip
      - qubes-core-agent-passwordless-root
      - qubes-ctap
      - qubes-usb-proxy
      - ripgrep
      - rsync
      - rust
      - rust-analyzer
      - rust-src
      - rustfmt
      - sqlite
      - texlive-latex
      - tito
      - tmux
      - tree
      - wget2-wget
      - yq
      - zsh
    - aggregate: true
  file.managed:
    - user: root
    - group: root
    - mode: '0600'
    - makedirs: true
    - names:
      - /etc/skel/.config/tmux/tmux.conf:
        - source: salt://templates/uses-stack-dev-f41/files/tmux.conf
        - source_hash: sha512=18d1f41f30a142e5e5f39310026ba815a846f1f85b78d4760cd788992c602fccc829a40fd7fe289c4f28984185e14992077ee9353b7e5ba330e9dfcbb214aa18
      - /etc/skel/.vimrc:
        - source: salt://templates/uses-stack-dev-f41/files/.vimrc
        - source_hash: sha512=3adc2963b52e1cab729b040a949da587f97033609c3a61937e63a0cc442dba647e677b00b419f924f7afa6fa3a80c5ca671c71f67110e5f071d71c328a831286
  user.present:
    - name: user
    - uid: 1000
    - gid: 1000
    - shell: /bin/zsh

{% endif %}
