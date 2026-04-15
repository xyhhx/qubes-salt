{%- if salt['pillar.get']('qubes:type') == 'template' -%}

'{{ slsdotpath }}: install requirements':
  pkg.installed:
    - pkgs:
      - split-gpg2

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
