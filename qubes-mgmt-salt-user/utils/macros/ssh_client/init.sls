{% macro configure_ssh_client(vault_vm='@default') %}

'/rw/config/rc.local.d/30-split-ssh.rc':
  - source: 'salt://utils/macros/ssh_client/files/split-ssh.rc'
  - user: root
  - group: root
  - mode: '0755'
  - makedirs: true
  - attrs: i

{%- if vault_vm != '@default' -%}

'/etc/environment.d/50-split-ssh-vault.conf':
  - source: 'salt://utils/macros/ssh_client/files/split-ssh-vault.conf'
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

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
