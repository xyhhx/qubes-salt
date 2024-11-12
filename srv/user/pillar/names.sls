# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
names:
  templates:
    base:
      debian: on-debian-12-minimal
      kicksecure: on-kicksecure-17
      fedora: on-fedora-40-minimal
      fedora_xfce: on-fedora-40-xfce
    providers:
      audio: provides-audio
      browsers_fedora: provides-browsers-on-fedora
      browsers_kicksecure: provides-browsers-on-kicksecure
      net: provides-net
      usb: provides-usb
    stacks:

  appvms:
  dispvms:
  standalones:
