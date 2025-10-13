{%- set vm_name = "uses-stack-dev" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
prefs:
  - memory: 8000
  - maxmem: 16000
  - vcpus: 4

{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

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
    - requires:
      - pkg: dnf-plugins-core
  pkg.installed:
    - pkgs:
      - bat
      - bind-utils
      - bottom
      - btop
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
      - qubes-usb-proxy
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

'{{ slsdotpath }}: configure qubes-ctapproxy':
  cmd.run:
    - names:
      - 'systemctl disable qubes-ctapproxy@sys-usb.service'
      - 'systemctl enable qubes-ctapproxy@disp-sys-usb.service':
        - creates: '/etc/systemd/system/multi-user.target.wants/qubes-ctapproxy@disp-sys-usb.service'

{% endif %}

{# vim: set ft=salt.jinja.yaml ts=2 sw=2 sts=2 et : #}
