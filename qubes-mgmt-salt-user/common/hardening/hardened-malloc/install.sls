{%- if salt['grains.get']('os_family') | lower == 'redhat' -%}

include:
  - common.pkgs.dnf-plugins-core

'hardened_malloc':
  pkgrepo.managed:
    - copr: 'secureblue/hardened_malloc'
    - require:
      - pkg: 'dnf-plugins-core'
  pkg.installed:
    - require:
      - pkgrepo: 'hardened_malloc'
  file.managed:
    - name: '/etc/sysctl.d/30-hardened_malloc-mapcount.conf'
    - source: 'salt://{{ tpldir }}/files/30-hardened-malloc.conf'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
    - require:
      - pkg: 'hardened_malloc'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
