# vim: set ts=2 sw=2 sts=2 et :
---

{% set name = "common.pkgs.netvm" %}
{% if grains.id != 'dom0' %}

{%- load_yaml as common_pkgs -%}
  - gnome-keyring
  - notification-daemon
  - qubes-core-agent-network-manager
  - qubes-core-agent-networking
{%- endload -%}


{%- set pkgs = salt['grains.filter_by']({
  'RedHat': [
    'NetworkManager-wifi',
    'network-manager-applet',
    'polkit'
  ],
  'Debian': [
    'lspi',
    'network-manager',
    'ntpd',
    'wpasupplicant'
  ]
  },
  default='RedHat'
  )
-%}

'{{ name }}':
  pkg.installed:
    - pkgs: {{ pkgs | union(common_pkgs) }}
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
