# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% if grains['os_family']|lower == 'redhat' %}

include:
  - common.https_proxy

hardened_malloc:
  pkgrepo.managed:
    - copr: secureblue/hardened_malloc
  pkg.installed:

'/etc/ld.so.preload':
  file.managed:
    - contents: 'libhardened_malloc.so'
    - mode: '0644'

{% endif %}