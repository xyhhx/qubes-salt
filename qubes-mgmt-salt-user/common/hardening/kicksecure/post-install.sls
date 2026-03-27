{%- if grains.os_family | lower == 'debian' -%}

'{{ slsdotpath }}:: disable kicksecure extrepo':
  cmd.run:
    - name: 'extrepo disable kicksecure'
    - use_vt: true

'/etc/apt/sources.list':
  file.managed:
    - contents: ""
    - require:
      - cmd: '{{ slsdotpath }}:: disable kicksecure extrepo'

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
