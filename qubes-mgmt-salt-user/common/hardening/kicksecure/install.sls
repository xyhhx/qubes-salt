{%- if grains.os_family | lower == 'debian' -%}

{#-
  TODO: A user should be able to configure whether this is done over clearnet, tor+clearnet, or onion url
  using pillar data
-#}

{%- load_yaml as repos -%}
plain_tls:
  transport: 'plain-tls'
  url: 'https://deb.kicksecure.com'
plain_tls_tor:
  transport: 'plain-tls-tor'
  url: 'tor+https://deb.kicksecure.com'
onion:
  transport: 'onion'
  url: 'tor+http://deb.w5j6stm77zs6652pgsij4awcjeel3eco7kvipheu6mtr623eyyehj4yd.onion'
onion_tls:
  transport: 'onion-tls'
  url: 'tor+https://deb.w5j6stm77zs6652pgsij4awcjeel3eco7kvipheu6mtr623eyyehj4yd.onion'
{%- endload -%}

{%- set repo = repos.plain_tls_tor -%}
{%- set derivative_key = '/usr/share/keyrings/derivative.asc' -%}
{%- set dist = salt['grains.get']('oscodename') -%}

'{{ slsdotpath }}:prereqs':
  pkg.installed:
    - pkgs:
      - 'apt-transport-tor'
    - install_recommends: false
  file.managed:
    - name: '{{ derivative_key }}'
    - source: 'salt://{{ tpldir }}/files/derivative.asc'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

'{{ slsdotpath }}:pkgrepo':
  pkgrepo.managed:
    - name: 'deb [signed-by={{ derivative_key }}] {{ repo.url }} {{ dist }} contrib main non-free'
    - dist: '{{ dist }}'
    - file: '/etc/apt/sources.list.d/derivative.list'
    - key_url: '{{ derivative_key }}'
    - require:
      - pkg: '{{ slsdotpath }}:prereqs'
      - file: '{{ slsdotpath }}:prereqs'
  pkg.uptodate:
    - refresh: true

'{{ slsdotpath }}: install kicksecure':
  pkg.installed:
    - pkgs:
      - 'kicksecure-qubes-server'
    - require:
      - pkgrepo: '{{ slsdotpath }}:pkgrepo'
    # sometimes the installation fails out, but works the second time
    - retry: true

'{{ slsdotpath }}: configure repos':
  cmd.run:
    - name: 'repository-dist -e -r stable -t {{ repo.transport }}'
    - use_vt: true
    - require:
      - pkg: '{{ slsdotpath }}: install kicksecure'

'/etc/apt/sources.list':
  file.managed:
    - contents: ""
    - require:
      - cmd: '{{ slsdotpath }}: configure repos'
    - onchanges:
      - pkgrepo: '{{ slsdotpath }}:pkgrepo'
      - pkg: '{{ slsdotpath }}: install kicksecure'
      - cmd: '{{ slsdotpath }}: configure repos'

include:
  - common.hardening.hardened-malloc.service

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
