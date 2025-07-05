{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

{% load_yaml as pkgmap %}
RedHat:
  - curl
  - procps-ng
  - vim-common
  - xclip
  - xfce4-notifyd
Debian:
  - curl
  - vim
  - xclip
  - xfce4-notifyd
{% endload %}

{%- set pkgs = salt['grains.filter_by'](pkgmap, default='RedHat') -%}

'{{ slsdotpath }}':
  pkg.installed:
    - pkgs: {{ pkgs }}

{% endif %}
