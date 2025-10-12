'{{ slsdotpath }}.{{ sls }}':
  file.recurse:
    - name: '/etc/dconf/db/local.d'
    - source: 'salt://{{ tpldir }}/files/etc/dconf/db/local.d'
    - user: root
    - group: root
    - dir_mode: '0755'
    - file_mode: '0644'
    - makedirs: true
  cmd.run:
    - name: 'dconf update'

{#- vim: set syntax=yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
