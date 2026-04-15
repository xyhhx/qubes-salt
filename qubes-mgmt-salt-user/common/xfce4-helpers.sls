{%- if salt["grains.get"]("qube:type") == "template" -%}
{%-   set helpersrc_file = "/etc/xfce4/helpers.rc" -%}
{%- else -%}
{%-   from "utils/user_info.jinja" import user_home -%}
{%-   set helpersrc_file = user_home | path_join(".config/xfce4/helpers.rc") -%}
{%- endif -%}

"{{ slsdotpath }}:: configure xfce4 helpers.rc":
  file.managed:
    - name: "{{ helpersrc_file }}"
    - contents: |
        TerminalEmulator=Alacritty
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true
    - replace: false

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
