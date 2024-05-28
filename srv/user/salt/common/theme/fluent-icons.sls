# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

{% if not salt['file.directory_exists']('/usr/share/icons/Fluent') %}

'curl -sLJ --proxy http://127.0.0.1:8082 https://github.com/vinceliuice/Fluent-icon-theme/archive/refs/heads/master.zip -o /tmp/fluent-icons.zip':
  cmd.run

'unzip -q /tmp/fluent-icons.zip -d /tmp':
  cmd.run

'/tmp/Fluent-icon-theme-master/install.sh -a -d /usr/share/icons':
  cmd.run

{% endif %}
