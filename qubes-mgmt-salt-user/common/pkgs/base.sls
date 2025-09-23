{% if grains.id != 'dom0' %}

{#- todo: handle debian and other os family -#}
{% load_yaml as pkgmap %}
RedHat:
  - curl
  - procps-ng
  - vim-common
  - xclip
{% endload %}

{%- set pkgs = salt['grains.filter_by'](pkgmap, default='RedHat') -%}

'{{ slsdotpath }}':
  pkg.installed:
    - pkgs: {{ pkgs }}

{% endif %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
