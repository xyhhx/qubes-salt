{%- if grains.id != 'dom0' -%}

'{{ slsdotpath }}::install-yad':
  pkg.installed:
    - pkgs:
      - yad

'{{ slsdotpath }}::erase-zenity':
  cmd.run:
    - name:'rpm -e --nodeps zenity' 
    - use_vt: true
    - require:
      - '{{ slsdotpath }}::install-yad'

'{{ slsdotpath }}::install-alternative':
  alternatives.install:
    - name: 'zenity'
    - link: '/usr/bin/zenity'
    - path: '/usr/bin/yad'
    - priority: 100
    - requires:
      - pkg: '{{ slsdotpath }}::erase-zenity'

'{{ slsdotpath }}::set-alternative':
  alternatives.set:
    - name: 'zenity'
    - path: '/usr/bin/yad'
    - requires:
      - alternatives: '{{ slsdotpath }}::install-alternative'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
