{%- if grains.id != "dom0" -%}
{%- from "utils/user_info.jinja" import user, user_home with context -%}

{#- https://forum.qubes-os.org/t/sound-in-trivalent-browser/36247/2 -#}
"{{ slsdotpath }}:: add pactl to autostart":
  file.managed:
    - name: "{{ user_home | path_join("/.config/autostart/pactl-info.desktop" )}}"
    - source: "salt://{{ tpldir | path_join("files/vm", user_home, ".config/autostart/pactl-info.desktop") }}"
    - user: "{{ user }}"
    - group: "{{ user }}"
    - mode: "0644"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
