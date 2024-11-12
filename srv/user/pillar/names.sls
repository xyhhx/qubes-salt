# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :
---
names:
  templates:
    base:
      debian: on-debian-12-minimal
      kicksecure: on-kicksecure-17
      fedora: on-fedora-40-minimal
      fedora_xfce: on-fedora-40-xfce
    providers:
      browsers-fedora: provides-browsers-on-fedora
      browsers-kicksecure: provides-browsers-on-kicksecure
      net: provides-net
    stacks:

  appvms:
  dispvms:
    browsers: dvm-browsers
  standalones:
