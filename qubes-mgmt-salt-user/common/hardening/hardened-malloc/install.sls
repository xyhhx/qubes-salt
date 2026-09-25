{%- if salt['grains.get']('os_family') | lower == 'redhat' -%}

include:
  - common.pkgs.dnf-plugins-core

'hardened_malloc':
  pkgrepo.managed:
    - copr: 'secureblue/packages'
    - require:
      - pkg: 'dnf-plugins-core'
  pkg.installed:
    - pkgs:
      - hardened_malloc
      - no_rlimit_as
    - require:
      - pkgrepo: 'hardened_malloc'
  file.managed:
    - names:
{% for file in [
  '/etc/environment.d/30_hardened_malloc-preload.conf',
  '/etc/profile.d/30_hardened_malloc-preload.sh',
  '/etc/security/pam_env.conf',
  '/etc/sysctl.d/30_hardened_malloc-mapcount.conf',
  '/usr/lib/systemd/system.conf.d/30_hardened_malloc.conf'
] %}
      - '{{ file }}':
        - source: 'salt://{{ tpldir | path_join('files/vm/', file) }}'
{% endfor %}
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
    - require:
      - pkg: 'hardened_malloc'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
