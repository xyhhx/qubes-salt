'{{ slsdotpath }}: homedirs':
  file.keyvalue:
    - names:
      - '/etc/login.defs':
        - key_values:
            UMASK: '077'
            HOME_MODE: '700'
      - '/etc/bashrc':
        - key_values:
            umask: '077'
    - separator: ' '
    - append_if_not_found: true
    - uncomment: '#'
    - key_ignore_case: true

'/home':
  file.directory:
    - dir_mode: '0700'
    - recurse:
      - mode
    - max_depth: 1
    - children_only: true

{#- vim: set syntax=salt.jinja.yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
