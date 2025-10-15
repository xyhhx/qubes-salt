{%- if grains.id == 'dom0' -%}
{%- from 'utils/user_info.jinja' import user with context -%}
{#- {%- set xf_perchannel_dir = '/home/' ~ user ~ '/.config/xfce4/xfconf/xfce-perchannel-xml' -%} -#}

'{{ slsdotpath }}':
  file.managed:
    - name: '/home/{{ user }}/Pictures/Wallpapers/wp.jpg'
    - source: 'salt://{{ tpldir }}/files/wp.jpg'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0644'
    - makedirs: true

{#- TODO: I don't trust tihs yet... -#}
{%- from tpldir ~ '/xfconf-query.jinja' import commands with context -%}
{%- for cmd in commands -%}
{%- do salt['log.debug'](cmd) -%}
{%- endfor -%}

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
