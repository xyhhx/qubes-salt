{%- from 'utils/user_info.jinja' import user -%}

'{{ slsdotpath }}:set_up_rpc_includes':
  file.managed:
    - names:
      - '/etc/qubes/policy.d/10-user-includes.policy':
        - source: 'salt://{{ tpldir }}/files/etc/qubes/policy.d/10-user-includes.policy.j2'
        - defaults:
            user: 'user'
        - template: jinja
      - '/etc/qubes/policy.d/20-salt-includes.policy':
        - source: 'salt://{{ tpldir }}/files/etc/qubes/policy.d/20-salt-includes.policy.j2'
    - owner: 'root'
    - group: 'root'
    - mode: '0644'
    - attrs: i
    - show_changes: true
    - makedirs: true

'{{ slsdotpath }}:set_up_rpc_includes':
  file.directory:
    - names:
      - '/home/{{ user }}/.config/qubes/policy.d/available'
      - '/home/{{ user }}/.config/qubes/policy.d/enabled'
    - owner: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0700'
    - attrs: i
    - show_changes: true
    - makedirs: true


# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
