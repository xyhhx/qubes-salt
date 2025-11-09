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

{% if salt['pillar.get']('qubes:type') in ['app', 'template'] %}

'{{ slsdotpath }}: set configs':
  file.managed:
    - names:
      - '{{ terminal.config_path }}/alacritty/alacritty.toml':
        - source: 'salt://{{ slspath }}/files/alacritty.toml.j2'
      - '{{ terminal.config_path }}/profile.d/50-set-ps1.conf':
        - source: 'salt://{{ tpldir }}/files/50-set-ps1.conf'
    - user: '{{ terminal.user }}'
    - group: '{{ terminal.group }}'
    - mode: '{{ terminal.mode }}'
    - makedirs: true
    - show_changes: true

{% endif %}

{# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : #}
