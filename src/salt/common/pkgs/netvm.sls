# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% set name = "common.pkgs.netvm" %}
{% if grains.id != 'dom0' %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - gnome-keyring
      - notification-daemon
      - qubes-core-agent-network-manager
      - qubes-core-agent-networking
{% if grains.os_family|lower == 'redhat' %}
      - NetworkManager-wifi
      - network-manager-applet
      - polkit
{% elif grains.os_family|lower == 'debian' %}
      - lspci
      - network-manager
      - ntpd
      - wpasupplicant
{% endif %}
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true

{% endif %}
