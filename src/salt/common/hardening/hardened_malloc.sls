{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

---
{% set name = "common.pkgs.hardened_malloc" %}

{% if grains.id != 'dom0' %}
{% if grains.os_family|lower == 'redhat' %}

include:
  - common.https_proxy

secureblue/hardened_malloc:
  pkgrepo.managed:
    - copr: secureblue/hardened_malloc
  pkg.installed:
    - name: hardened_malloc
    - require:
      - pkgrepo: secureblue/hardened_malloc
  file.managed:
    - mode: '0640'
    - user: root
    - group: root
    - makedirs: true
    - names:
      - '/etc/ld.so.preload':
        - contents: 'libhardened_malloc.so'
      - '/etc/sysctl.d/hardened_malloc.conf':
        - contents: 'vm.max_map_count = 1048576'
    - require:
      - pkg: hardened_malloc

{% endif %}
{% endif %}
