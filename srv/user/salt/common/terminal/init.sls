# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---
alacritty:
  pkg.installed
{% if grains.os_family|lower == 'debian' %}
      - libxkbcommon-x11-0
{% if grains.os_family|lower == 'redhat' %}
      - libxkbcommon
{% endif %}

'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50':
  cmd.run

'update-alternatives --set x-terminal-emulator /usr/bin/alacritty 50':
  cmd.run
