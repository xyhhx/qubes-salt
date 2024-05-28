# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

'common.theme.fluent-gtk - prereqs':
  pkg.installed:
    - pkgs:
      - gnome-themes-extra
      - sassc
{% if grains.os_family|lower == 'debian' %}
      - gtk2-engines-murrine
{% else %}
      - gtk-murrine-engine
{% endif %}

{% if not salt['file.directory_exists']('/usr/share/themes/Fluent') %}

'curl -sLJ --proxy http://127.0.0.1:8082 https://github.com/vinceliuice/Fluent-gtk-theme/archive/refs/heads/master.zip -o /tmp/fluent-gtk.zip':
  cmd.run

'unzip -q /tmp/fluent-gtk.zip -d /tmp':
  cmd.run

'/tmp/Fluent-gtk-theme-master/install.sh -t all -l --tweaks square':
  cmd.run

{% endif %}
