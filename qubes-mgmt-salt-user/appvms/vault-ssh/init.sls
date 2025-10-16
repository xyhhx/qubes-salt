{%- set vm_name = "vault-ssh" -%}
{%- set template_name = "provides-split-ssh" -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: gray
    - prefs:
      - template: '{{ template_name }}'
      - label: gray
      - netvm: ''
    - features:
      - enable:
        - service.custom-persist
      - set:
        - custom-persist.user_ssh: 'dir:user:user:0700:/home/user/.ssh'
        - custom-persist.ssh_autostart: 'file:user:user:0700:/home/user/.config/autostart/ssh-add.desktop'

'/usr/local/etc/qubes/policy.d/available/30-split-ssh.policy':
  file.managed:
    - source: 'salt://appvms/vault-ssh/files/split-ssh.policy.j2'
    - template: 'jinja'
    - user: root
    - group: qubes
    - mode: '0640'
    - attrs: 'i'
    - makedirs: true
    - replace: true
    - defaults:
        client_tag: 'split-ssh-client'
        policy: 'qubes.SshAgent'
        server_tag: 'split-ssh-server'
        vault_vm: 'vault-ssh'
    - context:
        vault_vm: '{{ vm_name }}'

'/usr/local/etc/qubes/policy.d/enabled/30-split-ssh.policy':
  file.symlink:
    - target: '/usr/local/etc/qubes/policy.d/available/30-split-ssh.policy'
    - makedirs: true
    - user: 'root'
    - group: 'qubes'
    - mode: '0777'

{% else %}

'/home/user/.config/autostart/ssh-add.desktop':
  file.managed:
    - source: 'salt://appvms/vault-ssh/files/ssh-add.desktop'
    - user: user
    - group: user
    - mode: '0600'
    - makedirs: true
    - replace: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :

