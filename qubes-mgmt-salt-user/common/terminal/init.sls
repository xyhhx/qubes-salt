{%- from "./map.jinja" import terminal with context -%}

{% if salt['pillar.get']('qubes:type') == 'template' %}

'{{ sls }} ~ install pkgs':
  pkg.installed:
    - pkgs: {{ terminal.pkgs }}

'{{ sls }} ~ update alternatives':
  cmd.run:
    - names:
      - 'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator {{ terminal.bin }} 50'
      - 'update-alternatives --set x-terminal-emulator {{ terminal.bin }}'
    - use_vt: true
    - onchanges:
      - pkg: '{{ sls }} ~ install pkgs'

{% endif %}

{% if salt['pillar.get']('qubes:type') in ['appvm', 'template'] %}

'{{ sls }} ~ config file':
  file.managed:
    - name: '{{ terminal.config_file.path }}/{{ terminal.config_file.name }}'
    - source: 'salt://{{ slspath }}/files/{{ terminal.config_file.name }}'
    - user: '{{ terminal.config_file.user }}'
    - group: '{{ terminal.config_file.group }}'
    - mode: '{{ terminal.config_file.mode }}'
    - makedirs: true
    - merge_if_exists: true
    - show_changes: true

{% endif %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
