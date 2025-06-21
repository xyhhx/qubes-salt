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
  - iwlwifi-dvm-firmware
  - iwlwifi-mvm-firmware
  - mesa-dri-drivers
  - mesa-va-drivers
  - mesa-vulkan-drivers
  - network-manager-applet
  - nxpwireless-firmware
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
