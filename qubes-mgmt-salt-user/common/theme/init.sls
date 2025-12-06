
{%- from './map.jinja' import pkgs, prefs with context -%}
{%- if grains.id != "dom0" -%}
{%- set qube_type = salt['pillar.get']('qubes:type') -%}

{%- if qube_type is eq 'template' -%}

'{{ slsdotpath }}:pkg.installed':
  pkg.installed:
    - pkgs: {{ pkgs | unique }}

  {%- set user = 'root' -%}
  {%- set config_dir = '/etc' -%}
  {%- set gtk2rc = '/etc/gtk-2.0/gtkrc' -%}

{%- else -%}

  {%- from 'utils/user_info.jinja' import user, user_home -%}

  {%- set config_dir = user_home ~ '/.config' -%}
  {%- set gtk2rc =  user_home ~ '/.gtkrc-2.0' -%}

{% endif %}

'{{ slsdotpath }}':
  file.managed:
    - names:
{% for db in ['color-scheme', 'fonts', 'gtk-theme', 'icon-theme'] %}
      - '{{ config_dir }}/dconf/db/local.d/{{ db }}':
        - source: 'salt://{{ tpldir }}/files/dconf/{{ db }}'
{% endfor %}
      - '{{ config_dir }}/gtk-4.0/settings.ini':
        - source: 'salt://{{ tpldir }}/files/gtk-3.0-settings.j2'
        - template: 'jinja'
      - '{{ config_dir }}/gtk-3.0/settings.ini':
        - source: 'salt://{{ tpldir }}/files/gtk-3.0-settings.j2'
        - template: 'jinja'
      - '{{ config_dir }}/gtk-3.0/overrides.css':
        - source: 'salt://{{ tpldir }}/files/overrides.css'
      - '{{ gtk2rc }}':
        - source: 'salt://{{ tpldir }}/files/gtkrc-2.0.j2'
        - template: 'jinja'
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
    - onchanges_in:
      - cmd: 'dconf update'

'dconf update':
  cmd.run:
    - use_vt: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
