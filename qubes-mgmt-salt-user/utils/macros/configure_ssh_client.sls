{% macro configure_ssh_client(vault_vm='@default') %}

'{{ slsdotpath }}:configure_ssh_client':
  file.managed:
    - names:
      - '/rw/config/rc.local.d/30-split-ssh.rc':
        - source: 'salt://utils/macros/files/split-ssh.rc'
        - mode: '0755'
      - '/etc/environment.d/50-split-ssh-vault.conf':
        - content: |
            SSH_VAULT_VM={{ vault_vm }}
        - mode: '0644'
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
    - attrs: i
    - defaults:
        vault_vm: '@default'
    - context:
        vault_vm: '{{ vault_vm }}'

{% endmacro %}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
