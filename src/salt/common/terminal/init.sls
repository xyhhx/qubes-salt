{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}


{%- set name = "common.terminal.alacritty" -%}

{%- set conf = salt['grains.filter_by'](
  {
    'RedHat': {
      'pkgs': [ 'libxkbcommon', 'libxkbcommon-x11' ],
      'config_file': 'alacritty.toml'
    },
    'Debian': {
      'pkgs': [ 'libxkbcommon-x11-0' ],
      'config_file': 'alacritty.yml'
    }
  },
  default='RedHat'
)
-%}

{% if salt['pillar.get']('qubes:type') == 'template' %}

'{{ name }}':
  pkg.installed:
    - pkgs: {{ conf.pkgs }}
  cmd.run:
    - names:
      - 'update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50'
      - 'update-alternatives --set x-terminal-emulator /usr/bin/alacritty'
    - use_vt: true
    - onchanges:
      - pkg: '{{ name }}'
  file.managed:
    - makedirs: true
    - names:
      - '/home/user/.config/alacritty/{{ conf.config_file }}':
        - source:  'salt://common/terminal/files/{{ conf.config_file }}'
      - '/etc/skel/.config/alacritty/{{ conf.config_file }}':
        - source: 'salt://common/terminal/files/{{ conf.config_file }}'

{% endif %}
