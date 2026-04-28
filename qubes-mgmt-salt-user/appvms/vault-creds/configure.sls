{%- if grains.id != "dom0" -%}

"/usr/local/share/keepassxc":
  file.directory:
    - user: 1000
    - group: 1000
    - dir_mode: "0700"
    - file_mode: "0600"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
