# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = 'common.neovim.init' %}
{% if grains['id'] != 'dom0' %}

https://github.com/AstroNvim/template.git:
  git.latest:
    - target: /home/user/.config/nvim
    - user: user

/home/user/.config/nvim/init.lua:
  file.managed:
    - source: salt://common/neovim/files/init.lua
    - user: 1000
    - group: 1000
    - mode: '0640'

{% endif %}


