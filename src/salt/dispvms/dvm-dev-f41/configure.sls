# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set vm_name = "dvm-dev-f41" %}
{% set name = "dispvms.dvm-dev-f41.configure" %}

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

https://github.com/tmux-plugins/tpm.git:
  git.latest:
    - target: /home/user/.tmux/plugins/tpm
    - user: user
    - onchanges_in:
      - cmd: tpm_update_plugins

tpm_install:
  cmd.run:
    - name: /home/user/.tmux/plugins/tpm/bin/install_plugins
    - runas: user
    - cwd: /home/user
    - env:
      - TMUX_PLUGIN_MANAGER_PATH: '/home/user/.config/tmux/plugins/'

tpm_update_plugins:
  cmd.run:
    - name: '/home/user/.tmux/plugins/tpm/bin/update_plugins all'
    - runas: user
    - cwd: /home/user
    - env:
      - TMUX_PLUGIN_MANAGER_PATH: '/home/user/.config/tmux/plugins/'

{% endif %}
