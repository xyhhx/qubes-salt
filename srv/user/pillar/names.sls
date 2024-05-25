# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

names:
  base_templates:
    debian: on-debian-12
    debian_minimal: on-debian-12-minimal
    fedora: on-fedora-39-xfce
    fedora_minimal: fedora-39-minimal
    kicksecure: salt_on-kicksecure-17
  templates: 
    stack_dev: uses-stack-dev-kicksecure-17
    provides_ivpn_fedora: salt_provides-ivpn-fedora
  dispvms:
    dev: dvm-dev-kicksecure-17
  appvms:
    ivpn_fedora: salt_sys-vpn-ivpn-fedora
