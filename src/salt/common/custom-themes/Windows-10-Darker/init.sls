{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if salt['pillar.get']('qubes:type') == 'template' %}

'/usr/share/themes/Windows-10-Darker':
  file.recurse:
    - source: salt://common/custom-themes/Windows-10-Darker
    - user: root
    - group: root
    - file_mode: '0644'
    - dir_mode: '0755'
    - clean: true
    - makedirs: true
    - replace: true

{% endif %}
