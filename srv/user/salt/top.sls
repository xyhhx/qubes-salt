# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

user:
  '*':
    - templates.on-debian-12-minimal
    - templates.on-fedora-40-minimal
    - templates.on-fedora-40-xfce
    - templates.on-fedora-41-minimal
    - templates.on-kicksecure-17

    - templates.provides-audio
    - templates.provides-browsers-on-fedora
    - templates.provides-net
    - templates.provides-usb
