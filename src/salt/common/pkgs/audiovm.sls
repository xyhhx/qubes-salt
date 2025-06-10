# vim: set ts=2 sw=2 sts=2 et :
---

{% set name = "common.pkgs.audio_vm" %}
{% if grains.id != 'dom0' and salt['pillar.get']('qubes:type') == 'template' %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - alsa-utils
      - easyeffects
      - blueman
      - linux-firmware
      - pasystray
      - pipewire-qubes
      - qubes-audio-daemon
      - pavucontrol
      - qubes-core-admin-client
      - qubes-usb-proxy
{% if grains.os_family|lower == 'debian' %}
      - libspa-0.2-bluetooth
{% endif %}
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
