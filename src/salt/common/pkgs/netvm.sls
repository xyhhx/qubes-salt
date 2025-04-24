# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set name = "common.pkgs.netvm" %}

'{{ name }} - update':
  pkg.uptodate:
    - refresh: true

'{{ name }} - install':
  pkg.installed:
    - pkgs:
{% if grains['os_family']|lower == 'redhat' %}
      - NetworkManager-wifi
      - network-manager-applet
      - notification-daemon
      - polkit
      - @hardware-support
{% elif grains['os_family']|lower == 'redhat' %}
      - wpasupplicant
      - ntpd
{% endif %}
    - skip_suggestions: true
    - install_recommends: false
    - order: 1

