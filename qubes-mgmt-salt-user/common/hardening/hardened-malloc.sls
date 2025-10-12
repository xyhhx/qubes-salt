include:
  - common.pkgs.dnf-plugins-core

'hardened_malloc':
  pkgrepo.managed:
    - copr: secureblue/hardened_malloc
    - require:
      - pkg: 'dnf-plugins-core'
  pkg.installed:
    - require:
      - pkgrepo: 'hardened_malloc'


'/etc/ld.so.preload':
{% if salt['file.file_exists']('/etc/ld.so.preload') %}
  file.append:
    - text: 'libhardened_malloc.so'
{% else %}
  file.managed:
    - contents: |
        libhardened_malloc.so
    - user: root
    - group: root
    - mode: '0644'
{% endif %}
    - prereq:
      - pkg: 'hardened_malloc'


{#- vim: set syntax=yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
