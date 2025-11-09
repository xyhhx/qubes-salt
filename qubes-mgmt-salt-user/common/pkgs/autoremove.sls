{%- if salt['grains.get']('os_family') | lower == 'debian' -%}
{%- if salt['pillar.get']('qubes:type') == 'template' -%}

'apt autoremove -y':
  cmd.run:
    - use_vt: true
    - order: last

{%- endif -%}
{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}

