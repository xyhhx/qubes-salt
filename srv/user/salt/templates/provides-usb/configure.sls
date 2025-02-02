# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - gnome-keyring
      - qubes-usb-proxy
      - qubes-input-proxy-sender
      - qubes-ctap
    - skip_suggestions: true
    - install_recommends: false
