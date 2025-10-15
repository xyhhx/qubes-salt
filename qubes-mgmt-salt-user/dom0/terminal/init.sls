{%- if grains.id == 'dom0' -%}
{%- from 'utils/user_info.jinja' import user with context -%}

'{{ slsdotpath }}: install deps':
  pkg.installed:
    - pkgs:
      - alacritty
      - dejavu-sans-mono-fonts

'{{ slsdotpath }}: install alacritty config':
  file.managed:
    - name: '/home/{{ user }}/.config/alacritty/alacritty.toml'
    - source: 'salt://{{ tpldir }}/files/alacritty.toml'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0644'
    - makedirs: true
    - template: 'jinja'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
