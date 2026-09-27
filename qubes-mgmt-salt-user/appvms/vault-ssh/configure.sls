{%- if grains.id != "dom0" -%}
{%- from "utils/user_info.jinja" import user -%}
{%- set filepath = "/home | path_join(user, ".config/autostart/ssh-add.desktop")" -%}

"{{ slsdotpath }}:: install autostart":
  file.managed:
    - name: "{{ filepath }}"
    - source: "salt://{{ tpldir | path_join("files/vm", filepath) }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0700"
    - makedirs: true
    - replace: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
