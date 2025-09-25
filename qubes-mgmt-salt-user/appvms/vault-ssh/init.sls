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
    - features:
      - enable:
        - service.custom-persist
      - set:
        - custom-persist.user_ssh: 'dir:user:user:0700:/home/user/.ssh'
  file.managed:
    - name: '/etc/qubes/policy.d/30-split-ssh.policy'
    - source: 'salt://appvms/vault-ssh/files/split-ssh.policy'
    - template: 'jinja'
    - replace: true
    - user: root
    - group: qubes
    - mode: '0640'
    - makedirs: true
    - defaults:
        client_tag: 'split-ssh-client'
        policy: 'qubes.SshAgent'
        server_tag: 'split-ssh-client'
        ssh_vault: 'vault-ssh'
    - context:
        ssh_vault: '{{ vm_name }}'

{% endif %}

# vim: set syn=salt ts=2 sw=2 sts=2 et : 

