{%- set vm_name = "uses-stack-dev" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

include:
  - common.pkgs.dnf-plugins-core

'{{ vm_name }}':
  pkgrepo.managed:
    - names:
      - 'bottom':
        - copr: atim/bottom
      - 'lazygit':
        - copr: dejan/lazygit
    - require:
      - pkg: dnf-plugins-core
  pkg.installed:
    - pkgs:
      - bat
      - bind-utils
      - bottom
      - btop
      - cascadia-code-nf-fonts
      - cargo
      - clippy
      - direnv
      - fd-find
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
      - qubes-ctap
      - qubes-core-agent-networking
      - qubes-core-agent-passwordless-root
      - qubes-usb-proxy
      - ripgrep
      - rsync
      - rustfmt
      - sqlite
      - texlive-latex
      - tmux
      - tree
      - wget2-wget
      - uv
      - yq
      - zsh
  user.present:
    - name: 'user'
    - shell: '/bin/zsh'
  file.managed:
    - name: '/etc/ssh/ssh_known_hosts'
    - source: 'salt://{{ tpldir }}/files/etc/ssh/ssh_known_hosts'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - attrs: 'i'
    - makedirs: true
  cmd.run:
    - names:
      - 'systemctl disable qubes-ctapproxy@sys-usb.service':
        - onlyif: '[ -L /etc/systemd/system/multi-user.target.wants/qubes-ctapproxy@sys-usb.service ]'
      - 'systemctl enable qubes-ctapproxy@disp-sys-usb.service':
        - creates: '/etc/systemd/system/multi-user.target.wants/qubes-ctapproxy@disp-sys-usb.service'
    - use_vt: true

'{{ slsdotpath }}: install tree-sitter':
  cmd.run:
    - name: |
        vm-run-vm --dispvm -- 'cargo install --locked tree-sitter-cli && cat ~/.cargo/bin/tree-sitter' > /usr/bin/tree-sitter
    - creates: '/usr/bin/tree-sitter'
    - uses_vt: true
  file.managed:
    - name: '/usr/bin/tree-sitter'
    - user: 'root'
    - group: 'root'
    - mode: '0755'

{% endif %}

{# vim: set ft=salt.jinja.yaml ts=2 sw=2 sts=2 et : #}

