{%- from './map.jinja' import terminal with context -%}

{% if salt['pillar.get']('qubes:type') == 'template' %}

'{{ slsdotpath }}':
  pkg.installed:
    - pkgs: {{ terminal.pkgs }}
  alternatives.install:
    - name: 'x-terminal-emulator'
    - link: '/usr/bin/x-terminal-emulator'
    - path: '{{ terminal.bin }}'
    - priority: 50
    - onchanges:
      - pkg: '{{ slsdotpath }}'

'x-terminal-emulator':
  alternatives.set:
    - path: '{{ terminal.bin }}'
    - onchanges:
      - alternatives: '{{ slsdotpath }}'

{% endif %}

{% if salt['pillar.get']('qubes:type') in ['appvm', 'template'] %}

'{{ terminal.config_file.path }}/{{ terminal.config_file.name }}':
  file.managed:
    - source: 'salt://{{ slspath }}/files/{{ terminal.config_file.name }}'
    - user: '{{ terminal.config_file.user }}'
    - group: '{{ terminal.config_file.group }}'
    - mode: '{{ terminal.config_file.mode }}'
    - makedirs: true
    - show_changes: true

{% endif %}

{# vim: set syntax=salt.jinja.yaml.yaml ts=2 sw=2 sts=2 et : #}
