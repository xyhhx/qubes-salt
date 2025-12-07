{%- macro set_papirus_icon_colors(color="default") -%}

include:
  - common.theme

'{{ slsdotpath }}::set-papirus-icon-colors':
  cmd.run:
    - require:
      - sls: 'common.theme'
    - name: 'papirus-folders -C {{ color }}'
    - use_vt: true

{%- endmacro -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
