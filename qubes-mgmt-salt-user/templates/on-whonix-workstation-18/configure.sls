{%- if grains.id != "dom0" -%}

include:
  - common.xfce4-helpers

"{{ slsdotpath }}:: configure user.prefs":
  file.managed:
    - names:
      - "/etc/sdwdate-gui.d/50_user.conf":
        - contents: |
            gateway=@default
      - "/etc/firefox-esr/50_prefs.js":
        - source: "salt://{{ tpldir | path_join("/files/vm/etc/firefox-esr/50_prefs.js") }}"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
