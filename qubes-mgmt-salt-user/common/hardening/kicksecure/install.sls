{%- if grains.os_family | lower == 'debian' -%}

{#-
  TODO: A user should be able to configure whether this is done over clearnet, tor+clearnet, or onion url
  using pillar data
-#}
{%- load_yaml as repo_transports -%}
clearnet: 'https://deb.kicksecure.com'
tor: 'tor+https://deb.kicksecure.com'
onion: 'tor+http://deb.w5j6stm77zs6652pgsij4awcjeel3eco7kvipheu6mtr623eyyehj4yd.onion'
{%- endload -%}

{%- set transport = repo_transports.clearnet -%}
{%- set derivative_key = '/usr/share/keyrings/derivative.asc' -%}

'{{ derivative_key }}':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/derivative.asc'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

'{{ slsdotpath }}:pkgrepo':
  pkgrepo.managed:
    - name: 'deb [signed-by={{ derivative_key }}] {{ transport }} bookworm main non-free contrib'
    - dist: 'bookworm'
    - file: '/etc/apt/sources.list.d/derivative.list'
    - key_url: 'salt://{{ tpldir }}/files/derivative.asc'
    - require:
      - file: '{{ derivative_key }}'

'kicksecure-qubes-cli':
  pkg.installed:
    - install_recommends: false
    - require:
      - pkgrepo: '{{ slsdotpath }}:pkgrepo'

'/etc/apt/sources.list':
  file.absent:
    - require:
      - pkg: 'kicksecure-qubes-cli'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}

