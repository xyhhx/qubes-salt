# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

'{{ vm_name }}':
  pkg.installed:
    pkgs:
      - alacritty
{% if grains.os_family|lower == 'debian' %}
      - libxkbcommon-x11-0
{% if grains.os_family|lower == 'redhat' %}
      - libxkbcommon
{% endif %}

'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50':
  cmd.run

'update-alternatives --set x-terminal-emulator /usr/bin/alacritty 50':
  cmd.run
