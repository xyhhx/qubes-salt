{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

https_proxy:
  environ.setenv:
    - name: https_proxy
    - value: 'http://127.0.0.1:8082'
    - update_minion: True

{% endif %}
