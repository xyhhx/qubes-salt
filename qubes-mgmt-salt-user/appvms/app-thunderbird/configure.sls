{%- if grains.id != "dom0" -%}
{%- from "utils/user_info.jinja" import user with context -%}

"{{ slsdotpath }}:: configure autostart":
  file.symlink:
    - name: "/home/user/.config/autostart/net.thunderbird.Thunderbird.desktop"
    - target: "/usr/share/applications/net.thunderbird.Thunderbird.desktop"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0700"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
