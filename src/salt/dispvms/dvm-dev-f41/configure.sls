# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = "dvm-dev-f41" %}
{% set name = "dispvms.dvm-dev-f41.configure" %}

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

'{{ name }}':
  git.latest:
    - name: https://github.com/tmux-plugins/tpm.git
    - target: /home/user/.tmux/plugins/tpm
    - user: user
  cmd.run:
    - names:
      - /home/user/.tmux/plugins/tpm/bin/install_plugins
      - /home/user/.tmux/plugins/tpm/bin/update_plugins all
        - onchanges:
          - git: '{{ name }}'
    - runas: user
    - cwd: /home/user
    - use_vt: true
    - env:
      - TMUX_PLUGIN_MANAGER_PATH: '/home/user/.config/tmux/plugins/'

{% endif %}
