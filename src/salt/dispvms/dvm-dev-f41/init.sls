# vim: set ts=2 sw=2 sts=2 et :
---

{% set name = "dispvms.dvm-dev-f41.init" %}
{% set vm_name = "dvm-dev-f41" %}
{% set template_name = "uses-stack-dev-f41" %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - memory: 8000
      - maxmem: 16000
      - vcpus: 4
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
        - service.qubes-ctapproxy@sys-onlykey
      - disable:
        - service.qubes-ctapproxy
      - set:
        - menu-items: Alacritty.desktop

'qvm-volume extend {{ vm_name }}:private 12Gi':
  cmd.run:
    - use_vt: true
    - onlyif:
      - 'qvm-ls {{ vm_name }}'
      - '[[ $(qvm-volume info {{ vm_name }}:private size | numfmt --to=iec-i) != 12Gi ]]'

{% else %}

'{{ name }}':
  git.latest:
    - name: https://github.com/tmux-plugins/tpm.git
    - target: /home/user/.tmux/plugins/tpm
    - user: user
  cmd.run:
    - names:
      - /home/user/.tmux/plugins/tpm/bin/install_plugins
      - '/home/user/.tmux/plugins/tpm/bin/update_plugins all':
        - onchanges:
          - git: '{{ name }}'
    - runas: user
    - cwd: /home/user
    - use_vt: true
    - env:
      TMUX_PLUGIN_MANAGER_PATH: '/home/user/.config/tmux/plugins/'
  file.append:
    - name: /rw/config/rc.local
    - source: salt://dispvms/dvm-dev-f41/templates/split-ssh-rc-local.j2
    - template: jinja
    - defaults:
        ssh_vault_vm: sys-onlykey

{% endif %}
