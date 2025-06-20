{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set name = "common.pkgs.netvm" -%}
{% if grains.id != 'dom0' %}

{%- load_yaml as pkgsmap -%}
common:
  - gnome-keyring
  - qubes-core-agent-network-manager
  - qubes-core-agent-networking
RedHat:
  - NetworkManager-wifi
  - network-manager-applet
  - polkit
Debian:
  - lspi
  - network-manager
  - ntpd
  - wpasupplicant
{%- endload -%}

{%- set pkgs = salt["grains.filter_by"](pkgsmap, base="common") -%}

'{{ name }}':
  pkg.installed:
    - pkgs: {{ pkgs | union(pkgsmap.common) }}
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
