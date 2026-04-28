{%- if grains.id != "dom0" -%}
{%- from "utils/user_info.jinja" import user -%}

"/home/user/.config/autostart/ssh-add.desktop":
  file.managed:
    - source: "salt://{{ tpldir | path_join("files/ssh-add.desktop") }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0700"
    - makedirs: true
    - replace: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
