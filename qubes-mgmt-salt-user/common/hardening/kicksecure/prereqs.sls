{%- if grains.os_family | lower == 'debian' -%}
{%- from 'utils/user_info.jinja' import user -%}

'{{ slsdotpath }}:update':
  pkg.uptodate:
    - refresh: true

'console':
  group.present:
    - system: true
    - addusers:
      - '{{ user }}'
    - require:
      - pkg: '{{ slsdotpath }}:update'

'{{ slsdotpath }}:pkgs':
  pkg.installed:
    - pkgs:
      - console-data
      - console-common
      - kbd
      - keyboard-configuration
    - require:
      - group: 'console'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}


