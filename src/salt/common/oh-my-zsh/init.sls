# vim: set ts=2 sw=2 sts=2 et :
---
{% if grains.id != 'dom0' and salt['pillar.get']('qubes:type') != 'template' %}

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

