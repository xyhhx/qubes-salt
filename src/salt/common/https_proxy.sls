{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

{#- https://www.qubes-os.org/doc/how-to-install-software/#using-the-updates-proxy -#}

updates_proxy:
  environ.setenv:
    - value:
        ALL_PROXY: http://127.0.0.1:8082
        HTTPS_PROXY: http://127.0.0.1:8082
        HTTP_PROXY: http://127.0.0.1:8082
        all_proxy: http://127.0.0.1:8082
        http_proxy: http://127.0.0.1:8082
        https_proxy: http://127.0.0.1:8082
    - update_minion: True

no_proxy:
  environ.setenv:
    - names:
      - no_proxy
      - NO_PROXY
    - value: '127.0.0.1'
    - update_minion: True

{% endif %}
