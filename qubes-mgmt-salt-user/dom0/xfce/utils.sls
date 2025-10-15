{%- if grains.id == 'dom0' -%}
{%- from 'utils/user_info.jinja' import user with context -%}

'{{ slsdotpath }}: utility scripts':
  file.managed:
    - names:
{% for script in [
  'x-center-active-window',
  'x-open-terminal-focused-qube',
  'x-xl-status'
] %}
      - '/home/{{ user }}/.local/bin/{{ script }}':
        - source: 'salt://{{ tpldir }}/files/{{ script }}'
{% endfor %}
    - user: '{{ user }}'
    - group: '{{ user }}'
    - mode: '0755'
    - makedirs: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
