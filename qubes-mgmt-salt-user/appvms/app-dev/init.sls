{%- set vm_name = "app-dev" -%}
{%- set template_name = "uses-stack-dev" -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: purple
    - prefs:
      - template: '{{ template_name }}'
      - label: purple
      - memory: 8000
      - maxmem: 16000
      - vcpus: 4
    - features:
      - enable:
        - service.qubes-ctap-proxy
        - service.split-gpg2-client
      - set:
        - menu-items: Alacritty.desktop
        - menu-favorites: Alacritty
    - tags:
      - add:
        - onlykey-ssh-client
        - onlykey-gpg-client

{% else %}

{%- from 'utils/user_info.jinja' import user with context -%}

include:
  - common.split-ssh-client

'{{ slsdotpath }}:init':
  git.cloned:
    - names:
      - 'https://github.com/astronvim/template':
        - target: '/home/{{ user }}/.config/nvim'
      - 'https://github.com/folke/lazy.nvim.git':
        - target: '/home/{{ user }}/.local/share/nvim/lazy/lazy.nvim'
        - require:
          - git: 'https://github.com/astronvim/template'
        - branch: 'stable'
    - user: '{{ user }}'
  cmd.run:
    - names:
      - 'nvim --headless +q'
      - 'starship init fish | source':
        - shell: '/usr/bin/fish'
    - runas: '{{ user }}'


{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
