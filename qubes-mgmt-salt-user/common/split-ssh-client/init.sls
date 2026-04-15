{%- if grains.id != 'dom0' -%}
{#-
  This sets configures the VM to proxy SSH agent calls to the SSH service VM
-#}
{%- if salt['pillar.get']('qubes:type') != 'template' -%}

{%- from 'utils/user_info.jinja' import user with context -%}

{%- load_yaml as files -%}
user_env: '/home/user/.config/environment.d/10-split-ssh.conf'
rc_local: '/rw/config/rc.local.d/30-split-ssh.rc'
{%- endload -%}

'{{ slsdotpath }}: set up ssh client':
  file.managed:
    - names:
      - '{{ files.user_env }}':
        - source: 'salt://{{ tpldir }}/files/vm{{ files.user_env }}'
        - mode: '0644'
      - '{{ files.rc_local }}':
        - source: 'salt://{{ tpldir }}/files/vm{{ files.rc_local }}'
        - mode: '0755'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - makedirs: true

{%- endif -%}
{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
