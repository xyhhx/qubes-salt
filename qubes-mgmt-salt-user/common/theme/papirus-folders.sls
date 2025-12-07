{%- if grains.id != "dom0" -%}
{%- if salt['pillar.get']('qubes:type') == 'template' -%}

'{{ slsdotpath }}::papirus-folders':
  file.recurse:
    - name: '/opt/papirus-folders'
    - source: 'salt://vendor/papirus-folders'
    - user: 'root'
    - group: 'root'
    - clean: true
    - dir_mode: '0755'
    - file_mode: '0644'
    - makedirs: true

'/opt/papirus-folders/papirus-folders':
  file.managed:
    - mode: '0755'
    - require:
      - file: '{{ slsdotpath }}::papirus-folders'

'/usr/bin/papirus-folders':
  file.symlink:
    - target: '/opt/papirus-folders/papirus-folders'
    - require:
      - file: '{{ slsdotpath }}::papirus-folders'

{%- endif -%}
{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
