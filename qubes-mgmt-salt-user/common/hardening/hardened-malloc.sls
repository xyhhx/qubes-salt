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
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - attrs: 'i'
{% endif %}
    - prereq:
      - pkg: 'hardened_malloc'

'/etc/sysctl.d/30-hardened_malloc-mapcount.conf':
  file.managed:
    - contents: |
        vm.max_map_count = 1048576
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - attrs: 'i'
    - makedirs: true


{#- vim: set syntax=salt.jinja.yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
