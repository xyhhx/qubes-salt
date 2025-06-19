{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- load_yaml as osmap %}
RedHat:
  pkgs:
    - alacritty
    - libxkbcommon
    - libxkbcommon-x11
  config_file: alacritty.toml
Debian:
  pkgs:
    - alacritty
    - libxkbcommon-x11-0
  config_file: alacritty.yml
{% endload -%}

{%- set conf = salt['grains.filter_by'](osmap, default='RedHat') -%}

{% if salt['pillar.get']('qubes:type') == 'template' %}

'{{ slsdotpath }}':
  pkg.installed:
    - pkgs: {{ conf.pkgs }}
  file.managed:
    - name: '/etc/skel/.config/alacritty/{{ conf.config_file }}'
    - source: 'salt://common/terminal/files/{{ conf.config_file }}'
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
  cmd.run:
    - names:
      - 'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50'
      - 'update-alternatives --set x-terminal-emulator /usr/bin/alacritty'
    - use_vt: true
    - onchanges:
      - pkg: {{ slsdotpath }}

{% elif salt["pillar.get"]("qubes:type") == "appvm" %}

'/home/user/.config/alacritty/{{ conf.config_file }}':
  file.managed:
    - source:  'salt://common/terminal/files/{{ conf.config_file }}'
    - makedirs: true
    - user: 1000
    - group: 1000
    - mode: '0600'

{% endif %}
