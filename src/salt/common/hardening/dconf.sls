{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---

{% if grains.id != 'dom0' and salt['pillar.get']('qubes:type') == 'template' %}

'/etc/dconf/db/site.d':
  file.recurse:
    - source: salt://common/hardening/files/dconf
    - user: root
    - group: root
    - file_mode: '0640'
    - dir_mode: '0750'
    - clean: true
    - makedirs: true
    - replace: true
    - onchanges_in:
      - cmd: 'dconf update'

'dconf update':
  cmd.run:
    - use_vt: true

{% endif %}
