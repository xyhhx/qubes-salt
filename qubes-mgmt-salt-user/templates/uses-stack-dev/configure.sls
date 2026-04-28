{%- if grains.id != "dom0" -%}

{%- from "utils/user_info.jinja" import user -%}
{%- set ssh_known_hosts_file = "/etc/ssh/ssh_known_hosts" -%}

include:
  - common.pkgs.dnf-plugins-core
  - common.pkgs.docker

"{{ slsdotpath }}:: install pkgrepos":
  pkgrepo.managed:
    - require:
      - sls: common.pkgs.dnf-plugins-core
    - names:
      - "bottom":
        - copr: atim/bottom
      - "lazygit":
        - copr: dejan/lazygit
      - "starship":
        - copr: atim/starship

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - require:
      - pkgrepos: "{{ slsdotpath }}:: install pkgrepos"
    - pkgs:
      - bat
      - bind-utils
      - bottom
      - btop
      - bzip2
      - cargo
      - cascadia-code-nf-fonts
      - clippy
      - direnv
      - fd-find
      - fish
      - gawk
      - git
      - git-delta
      - golang
      - iputils
      - jq
      - just
      - lazygit
      - lua
      - luarocks
      - neovim
      - nodejs
      - nodejs-npm
      - opentofu
      - pipx
      - pnpm
      - podman
      - psutils
      - qubes-core-agent-networking
      - qubes-core-agent-passwordless-root
      - qubes-ctap
      - qubes-usb-proxy
      - ripgrep
      - rsync
      - rustfmt
      - sqlite
      - split-gpg2
      - starship
      - texlive-latex
      - tmux
      - tree
      - uv
      - wget2-wget
      - yq
    - require:
      - pkgrepo: "{{ slsdotpath }}:: install pkgrepos"
    - require_in:
      - sls: common.pkgs.docker

"{{ slsdotpath }}:: populate known_hosts":
  file.managed:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: "{{ ssh_known_hosts_file }}"
    - source: "salt://{{ tpldir | path_join("files/vm", ssh_known_hosts_file) }}"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

"{{ slsdotpath }}:: configure user shell":
  user.present:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: "user"
    - shell: "/usr/bin/fish"

"{{ slsdotpath }}: install tree-sitter":
  cmd.run:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: |
        vm-run-vm @dispvm:dvm-dev -- "cargo install --locked tree-sitter-cli && cat ~/.cargo/bin/tree-sitter" > /usr/bin/tree-sitter
    - creates: "/usr/bin/tree-sitter"
    - uses_vt: true

"{{ slsdotpath }}:: configure tree-sitter bin":
  file.managed:
    - require:
      - cmd: "{{ slsdotpath }}: install tree-sitter"
    - name: "/usr/bin/tree-sitter"
    - user: "root"
    - group: "root"
    - mode: "0755"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
