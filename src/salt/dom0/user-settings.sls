{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% set user = salt["pillar.get"]("opts:dom0_user") %}

{% if grains.id == 'dom0' %}

'/home/{{ user }}/.local/bin/center-window-xfce.sh':
  file.managed:
    - source: 'salt://dom0/files/center-window-xfce.sh'
    - makedirs: true
    - mode: '0750'

{% endif %}
