
{%- from './map.jinja' import pkgs, prefs with context -%}

{%- set qube_type = salt['pillar.get']('qubes:type') == 'template' -%}

{%- if qube_type is eq 'template' -%}
  {%- set user = 'root' -%}
  {%- set config_dir = '/etc' -%}

'{{ slsdotpath }}:pkg.installed':
  pkg.installed:
    - pkgs: {{ pkgs | unique }}

{%- else -%}
  {%- from 'utils/user_info.jinja' import user, user_home -%}
  {%- set config_dir = user_home ~ '/.config' -%}
{%- endif -%}

'{{ slsdotpath }}':
  file.managed:
    - names:
{% for db in ['color-scheme', 'fonts', 'gtk-theme', 'icon-theme'] %}
      - '{{ config_dir }}/dconf/db/local.d/{{ db }}':
        - source: 'salt://common/theme/files/dconf/{{ db }}'
{% endfor %}
      - '{{ config_dir }}/gtk-3.0/overrides.css':
        - source: 'salt://common/theme/files/overrides.css'
    - context:
        cursor_theme:  '{{ prefs.theme.cursor }}'
        gtk_theme: '{{ prefs.theme.gtk }}'
        icon_theme: '{{ prefs.theme.icon }}'
        mono_font: '{{ prefs.fonts.mono }}'
        sans_font: '{{ prefs.fonts.sans }}'
        serif_font: '{{ prefs.fonts.serif }}'
    - defaults:
        cursor_theme: 'Adwaita'
        gtk_theme: 'Adwaita'
        icon_theme: 'Adwaita'
        mono_font: 'Noto Sans Mono 10'
        sans_font: 'Noto Sans 10'
        serif_font: 'Noto Serif 10'
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0644'
    - makedirs: true
    - replace: true
    - template: jinja

'dconf update':
  cmd.run:
    - use_vt: true

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
