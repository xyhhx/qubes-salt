# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = "common.oh-my-zsh.init" %}
{% if grains['id'] == 'dom0' %}

https://github.com/ohmyzsh/ohmyzsh.git:
  git.cloned:
    - target: /home/user/.oh-my-zsh

  file.managed:
    - user: 1000
    - group: 1000
    - mode: "0644"
    - names:
      - /home/user/.zshrc:
        - source: salt://common/oh-my-zsh/files/zshrc
      - /home/user/.oh-my-zsh/custom:
        - source: salt://common/oh-my-zsh/files/zsh_custom

{% endif %}

