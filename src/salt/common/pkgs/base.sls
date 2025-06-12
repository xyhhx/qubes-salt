{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set name = "common.pkgs.base" -%}

{% if grains.id != 'dom0' %}

{%- load_yaml as common_pkgs -%}
  - curl
  - notification-daemon
  - xclip
{%- endload -%}

{%- set os_pkgs = salt['grains.filter_by']({
  'RedHat': ['vim'],
  'Debian': ['vim-common']
  },
  default='RedHat'
)
-%}

'{{ name }}':
  pkg.installed:
    - pkgs: {{ common_pkgs | union(os_pkgs) }}
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
