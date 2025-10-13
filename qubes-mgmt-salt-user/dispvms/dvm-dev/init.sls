{%- set vm_name = "dvm-dev" -%}
{%- set template_name = "uses-stack-dev" -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template: '{{ template_name }}'
      - label: red
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
        - service.qubes-ctap-proxy
      - set:
        - menu-items: Alacritty.desktop
        - menu-favorites: "@disp:Alacritty"

{% else %}

'{{ slsdotpath }}:init':
  cmd.run:
    - names:
      - 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended':
        - creates: '/home/user/.oh-my-zsh'
      - 'git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim':
        - creates: '/home/user/.config/nvim/lua/community.lua'
    - runas: 'user'
  file.absent:
    - name: '/home/user/.config/nvim/.git'

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
