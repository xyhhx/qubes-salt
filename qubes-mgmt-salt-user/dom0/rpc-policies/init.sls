{%- if grains.id == 'dom0' -%}
{%- from 'utils/user_info.jinja' import user with context -%}

'{{ slsdotpath }}:set_up_rpc_includes':
  file.managed:
    - names:
      - '/etc/qubes/policy.d/10-user-includes.policy':
        - source: 'salt://{{ tpldir }}/files/etc/qubes/policy.d/10-user-includes.policy.j2'
        - context:
            user: '{{ user }}'
        - defaults:
            user: 'user'
      - '/etc/qubes/policy.d/20-salt-includes.policy':
        - source: 'salt://{{ tpldir }}/files/etc/qubes/policy.d/20-salt-includes.policy.j2'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - attrs: i
    - show_changes: true
    - makedirs: true
    - template: 'jinja'

'{{ slsdotpath }}:set_up_rpc_user_dirs':
  file.directory:
    - names:
      - '/home/{{ user }}/.config/qubes/policy.d/available'
      - '/home/{{ user }}/.config/qubes/policy.d/enabled'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0700'
    - attrs: i
    - show_changes: true
    - makedirs: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :-#}
