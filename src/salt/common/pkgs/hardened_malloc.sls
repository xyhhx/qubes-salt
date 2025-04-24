# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
{% set name = "common.pkgs.hardened_malloc" %}
{% if grains['os_family']|lower == 'redhat' %}

include:
  - common.https_proxy

'{{ name }} - pkgrepo.managed':
  pkgrepo.managed:
    - copr: secureblue/hardened_malloc

hardened_malloc:
  pkg.installed

'/etc/ld.so.preload':
  file.managed:
    - contents: 'libhardened_malloc.so'
    - mode: "0644"

'/etc/sysctl.d/hardened_malloc.conf':
  file.managed:
    - contents: 'vm.max_map_count = 1048576'
    - mode: "0644"

{% endif %}
