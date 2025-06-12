{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---

{% if salt['pillar.get']('qubes:type') == 'template' %}

{% load_yaml as defaults %}
  gtk_theme: 'Flat-Remix-Gtk-White-Darkest'
  icon_theme: 'Flat-Remix-Black-Dark'
  cursor_theme: 'Adwaita'
  sans_font: 'Liberation Sans 10'
  mono_font: 'IBM Plex Mono 11'
{% endload %}
{%- from 'osmap.jinja' import pkgs with context -%}

'{{ name }}':
  pkg.installed:
    - pkgs: {{ pkgs | selectattr('fonts', 'gtk_themes', 'icon_themes') | unique }}
  file.managed:
    - names:
      - /etc/pam_environment.d/10_qt_qpa.conf:
        - contents: |
            QT_QPA_PLATFORMTHEME=gtk3
      - /etc/xdg-desktop-portal/portals.conf:
        - contents: |
            [preferred]
            default=gtk;
      - /usr/share/gtk-2.0/gtkrc:
        - source: salt://common/theme/files/gtk-settings/gtkrc-2.0
      - /usr/share/gtk-3.0/settings.ini:
        - source: salt://common/theme/files/gtk-settings.gtk3.ini
      - /etc/dconf/db/local.d/00_gtk:
        - source: salt://common/theme/files/dconf/gtk
      - /etc/dconf/db/local.d/00_colors:
        - source: salt://common/theme/files/dconf/colors
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - replace: true
  cmd.run:
    - name: 'dconf update'
    - use_vt: true

{% endif %}
