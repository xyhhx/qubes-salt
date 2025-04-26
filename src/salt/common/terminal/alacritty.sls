# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

{% set name = "common.terminal.init" %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - alacritty
{% if grains.os_family|lower == 'debian' %}
      - libxkbcommon-x11-0
{% elif grains.os_family|lower == 'redhat' %}
      - libxkbcommon
      - libxkbcommon-x11
{% endif %}

  cmd.run:
    - names:
      - 'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50'
      - 'update-alternatives --set x-terminal-emulator /usr/bin/alacritty'

  file.managed:
    - makedirs: true
    - names:
{% if grains.os_family|lower == 'debian' %}
      - /home/user/.config/alacritty/alacritty.yml:
        - source: salt://common/terminal/files/alacritty.yml
      - /etc/skel/.config/alacritty/alacritty.yml:
        - source: salt://common/terminal/files/alacritty.yml
{% elif grains.os_family|lower == 'redhat' %}
      - /home/user/.config/alacritty/alacritty.toml:
        - source: salt://common/terminal/files/alacritty.toml
      - /etc/skel/.config/alacritty/alacritty.toml:
        - source: salt://common/terminal/files/alacritty.toml
{% endif %}
