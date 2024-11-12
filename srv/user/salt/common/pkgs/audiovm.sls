# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'common.pkgs.audiovm - update':
  pkg.uptodate:
    - refresh: true

'common.pkgs.audiovm - install':
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
{% if grains['os_family']|lower == 'debian' %}
      - libspa-0.2-bluetooth
{% endif %}
    - skip_suggestions: true
    - install_recommends: false
    - order: 1

