{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:stack:dev", "uses-stack-dev") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

'{{ vm_name }}':
  pkgrepo.managed:
    - name: bat-extras
    - copr: awood/bat-extras
  pkg.installed:
    - pkgs:
      - bat
      - bat-extras
      - bind-utils
      - btop
      - cargo
      - clippy
      - direnv
      - fd-find
      - git
      - git-delta
      - iputils
      - jq
      - just
      - lua
      - luarocks
      - opentofu
      - pipx
      - podman
      - psutils
      - python3-pip
      - qubes-core-agent-passwordless-root
      - qubes-usb-proxy
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
  file.managed:
    - user: root
    - group: root
    - mode: '0600'
    - makedirs: true
    - names:
      - /etc/skel/.config/tmux/tmux.conf:
        - source: salt://templates/uses-stack-dev/files/tmux.conf
      - /etc/skel/.vimrc:
        - source: salt://templates/uses-stack-dev/files/.vimrc
      - /etc/environment:
        - contents: |
            QUBES_SPLIT_SSH_SOCK=/var/run/user/1000/sys-onlykey
        - mode: '0644'
  user.present:
    - name: user
    - uid: 1000
    - gid: 1000
    - shell: /bin/zsh

{% endif %}
