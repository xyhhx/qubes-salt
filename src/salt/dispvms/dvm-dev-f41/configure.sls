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

{% endif %}
