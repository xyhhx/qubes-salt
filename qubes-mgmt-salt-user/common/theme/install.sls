{%- if grains.id != "dom0" -%}
{%- set qube_type = salt["pillar.get"]("qubes:type") -%}
{%- from "./map.jinja" import pkgs, prefs with context -%}

{%   if qube_type == "template" %}

"{{ slsdotpath }}:: pkg.installed":
  pkg.installed:
    - pkgs: {{ pkgs | unique }}

  {%- set user = "root" -%}
  {%- set config_dir = "/etc" -%}
  {%- set gtk2rc = "/etc/gtk-2.0/gtkrc" -%}
  {%- set theme_dir = "/usr/share/themes" %}

{%   else %}

  {%- from "utils/user_info.jinja" import user, user_home -%}
  {%- set config_dir = user_home ~ "/.config" -%}
  {%- set gtk2rc =  user_home ~ "/.gtkrc-2.0" -%}
  {%- set theme_dir = "/usr/local/share/themes" -%}

{%   endif %}

"{{ slsdotpath }}:: custom-theme":
  file.recurse:
    - name: "{{ theme_dir | path_join("/pane-black-gtk-theme") }}"
    - source: "salt://vendor/pane-black-gtk-theme"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - clean: true
    - dir_mode: "0755"
    - file_mode: "0644"
    - makedirs: true

"{{ slsdotpath }}":
  file.managed:
    - names:

{%  for db in ["color-scheme", "fonts", "gtk-theme", "icon-theme"] %}
      - "{{ config_dir | path_join("/dconf/db/local.d", db) }}":
        - source: "salt://{{ tpldir | path_join("files/dconf", db) }}"
{%  endfor %}

      - "{{ config_dir | path_join("/gtk-3.0/overrides.css") }}":
        - source: "salt://{{ tpldir | path_join("files/overrides.css") }}"

      - "{{ config_dir | path_join("/gtk-4.0/settings.ini") }}":
        - source: "salt://{{ tpldir | path_join("files/gtk-3.0-settings.j2") }}"
        - template: "jinja"

      - "{{ config_dir | path_join("/gtk-3.0/settings.ini") }}":
        - source: "salt://{{ tpldir | path_join("files/gtk-3.0-settings.j2") }}"
        - template: "jinja"

      - "{{ gtk2rc }}":
        - source: "salt://{{ tpldir | path_join("files/gtkrc-2.0.j2") }}"
        - template: "jinja"

      - "{{ config_dir | path_join("/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml") }}":
        - source: "salt://{{ tpldir | path_join("files/xsettings.xml.j2") }}"
        - template: "jinja"

    - context:
        cursor_theme:  "{{ prefs.theme.cursor }}"
        gtk_theme: "pane-black-gtk-theme"
        icon_theme: "{{ prefs.theme.icon }}"
        mono_font: "{{ prefs.fonts.mono }}"
        sans_font: "{{ prefs.fonts.sans }}"
        serif_font: "{{ prefs.fonts.serif }}"

    - defaults:
        cursor_theme: "Adwaita"
        gtk_theme: "Adwaita"
        icon_theme: "Adwaita"
        mono_font: "Noto Sans Mono 10"
        sans_font: "Noto Sans 10"
        serif_font: "Noto Serif 10"

    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0644"
    - makedirs: true
    - replace: true
    - template: jinja
    - onchanges_in:
      - cmd: "dconf update"

"dconf update":
  cmd.run:
    - uses_vt: true

{%  if qube_type == "template" %}

"/etc/gtk-4.0/gtk.css":
  file.symlink:
    - target: "/usr/share/themes/pane-black-gtk-theme/gtk-4.0/gtk.css"
    - force: true
    - backup: "gtk.css.bak"

{%  else %}

"{{ user_home | path_join(".config/gtk-4.0/gtk.css")}}":
  file.symlink:
    - target: "/usr/local/share/themes/pane-black-gtk-theme/gtk-4.0/gtk.css"
    - force: true
    - backup: "gtk.css.bak"
{%   endif %}
{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
