{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:dispvms:dev") -%}
{%- set template_name = salt["pillar.get"]("vm_names:templates:stack:dev") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: red
    - prefs:
      - template: '{{ template_name }}'
      - label: red
      - memory: 8000
      - maxmem: 16000
      - vcpus: 4
      - template-for-dispvms: true
    - features:
      - enable:
        - appmenus-dispvm
        - service.qubes-ctap-proxy
        - service.split-gpg2-client
      - set:
        - menu-items: Alacritty.desktop
    - tags:
      - add:
        - split-gpg2-client
        - onlykey-client
        - dev-vm

'qvm-volume extend {{ vm_name }}:private 12Gi':
  cmd.run:
    - use_vt: true
    - onlyif:
      - 'qvm-ls {{ vm_name }}'
      - '[[ $(qvm-volume info {{ vm_name }}:private size | numfmt --to=iec-i) != 12Gi ]]'

{% else %}

'{{ vm_name }}':
  git.latest:
    - name: https://github.com/tmux-plugins/tpm.git
    - target: /home/user/.tmux/plugins/tpm
    - user: user
  cmd.run:
    - names:
      - /home/user/.tmux/plugins/tpm/bin/install_plugins
      - '/home/user/.tmux/plugins/tpm/bin/update_plugins all':
        - onchanges:
          - git: 'https://github.com/tmux-plugins/tpm.git'
    - runas: user
    - cwd: /home/user
    - use_vt: true
    - env:
      - TMUX_PLUGIN_MANAGER_PATH: '/home/user/.config/tmux/plugins/'
  file.recurse:
    - name: /rw/config/rc.local.d
    - source:
      - salt://dispvms/dvm-dev/files/rc.local.d
    - user: root
    - group: root
    - dir_mode: '0755'
    - file_mode: '0755'
    - makedirs: true
    - clean: true
    - template: jinja
    - defaults:
          ssh_vault_vm: sys-onlykey
          split_gpg2_vault: vault-pgp
      context:
          ssh_vault_vm: "{{ salt["pillar.get"]("vm_names:sys_vms:onlykey", "sys-onlykey") }}"
          split_gpg2_vault: "{{ salt["pillar.get"]("vm_names:appvms:vault_pgp", "vault-pgp") }}"

/home/user/.config/oh-my-zsh/user.d:
  file.recurse:
    - source: salt://dispvms/dvm-dev/files/user.d
    - user: 1000
    - group: 1000
    - file_mode: "0640"
    - dir_mode: "0750"
    - makedirs: true
    - clean: true

{% endif %}
