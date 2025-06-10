{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---
{% if grains.id != 'dom0' and salt['pillar.get']('qvm:type') != 'template' %}

https://github.com/AstroNvim/template.git:
  git.cloned:
    - target: /home/user/.config/nvim
    - user: user
    - onchanges_in:
      - file: /home/user/.config/nvim/init.lua
      - file: /home/user/.config/nvim/lua

/home/user/.config/nvim/init.lua:
  file.managed:
    - source: salt://common/neovim/files/init.lua
    - user: 1000
    - group: 1000
    - mode: '0640'

/home/user/.config/nvim/lua:
  file.recurse:
    - source: salt://common/neovim/files/lua
    - user: 1000
    - group: 1000
    - file_mode: '0640'
    - dir_mode: '0750'
    - clean: true

{% endif %}


