{%- if grains.id != 'dom0' -%}
{#- https://www.qubes-os.org/doc/how-to-install-software/#using-the-updates-proxy -#}

updates_proxy:
  environ.setenv:
    - names:
      - ALL_PROXY
      - HTTPS_PROXY
      - HTTP_PROXY
      - all_proxy
      - http_proxy
      - https_proxy
    - value: 'http://127.0.0.1:8082'
    - update_minion: true
    - reload_modules: true

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
