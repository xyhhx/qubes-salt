{% macro configure_ssh_client(vault_vm='@default') %}

'/rw/config/rc.local.d/30-split-ssh.rc':
  - content: |
      SSH_VAULT_VM={{ vault_vm }}
  - user: root
  - group: root
  - mode: '0755'
  - makedirs: true
  - attrs: i

{%- if vault_vm != '@default' -%}

'/etc/environment.d/50-split-ssh-vault.conf':
  - source: 'salt://utils/macros/files/split-ssh-vault.conf'
  - template: jinja
  - user: root
  - group: root
  - mode: '0644'
  - makedirs: true
  - attrs: i
  - defaults:
      vault_vm: '@default'
  - context:
      vault_vm: '{{ vault_vm }}'

{%- endif -%}

{% endmacro %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et : 
