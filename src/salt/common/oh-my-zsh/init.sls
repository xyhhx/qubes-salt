# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = "common.oh-my-zsh.init" %}
{% if grains['id'] != 'dom0' %}

https://github.com/ohmyzsh/ohmyzsh.git:
  git.latest:
    - target: /home/user/.local/share/oh-my-zsh

/home/user/.zshrc:
  file.managed:
    - source: salt://common/oh-my-zsh/files/zshrc
    - user: 1000
    - group: 1000
    - mode: "0640"

{% endif %}

