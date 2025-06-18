{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

{% load_yaml as pkgmap %}
common:
  - curl
  - notification-daemon
  - xclip
RedHat:
  - vim-common
Debian:
  - vim
{% endload %}

{%- set pkgs = salt['grains.filter_by'](pkgmap, base='common')-%}

'{{ slsdotpath }}':
  pkg.installed:
    - pkgs: {{ pkgs }}
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
