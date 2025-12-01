{%- if salt['grains.get']('os_family') | lower == 'redhat' -%}
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
  file.managed:
    - names:
      - '/etc/sysctl.d/30-hardened_malloc-mapcount.conf':
        - contents: |
            vm.max_map_count = 1048576
      - '/usr/lib/systemd/system/hardened_malloc.service':
        - source: 'salt://{{ tpldir }}/files/usr/lib/systemd/system/hardened_malloc.service'
      - '/usr/share/qubes-user/preload-hardened-malloc':
        - source: 'salt://{{ tpldir }}/files/usr/share/qubes-user/preload-hardened-malloc'
        - mode: '0755'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
    - require:
      - pkg: 'hardened_malloc'
  service.enabled:
    - require:
      - file: 'hardened_malloc'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
