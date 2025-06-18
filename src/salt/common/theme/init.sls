{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if salt['pillar.get']('qubes:type') == 'template' %}

{% from slspath ~ "/maps/pkgs.jinja" import pkgs with context %}
{% from slspath ~ "/maps/prefs.jinja" import prefs with context %}

'{{ slsdotpath }}':
  pkg.installed:
    - pkgs: {{ pkgs | unique }}
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
        - source: salt://common/theme/files/gtk-settings/gtk3.ini
      - /etc/dconf/db/local.d/00_gtk:
        - source: salt://common/theme/files/dconf/gtk
      - /etc/dconf/db/local.d/00_colors:
        - source: salt://common/theme/files/dconf/colors
    - context:
        cursor_theme:  '{{ prefs.cursor_theme }}'
        sans_font: '{{ prefs.sans_font }}'
        mono_font: '{{ prefs.mono_font }}'
        gtk_theme: '{{ prefs.gtk_theme }}'
        icon_theme: '{{ prefs.icon_theme }}'
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - replace: true
    - template: jinja
  cmd.run:
    - name: 'dconf update'
    - use_vt: true
    - onchanges:
      - file: /etc/dconf/db/local.d/00_gtk
      - file: /etc/dconf/db/local.d/00_colors

{% endif %}
