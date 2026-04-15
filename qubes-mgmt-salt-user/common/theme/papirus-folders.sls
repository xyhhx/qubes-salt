{%- if grains.id != "dom0" -%}
{%-   if salt["pillar.get"]("qubes:type") == "template" -%}
{#-

"{{ slsdotpath }}:: papirus-folders":
  file.recurse:
    - name: "/opt/papirus-folders"
    - source: "salt://vendor/papirus-folders"
    - user: "root"
    - group: "root"
    - dir_mode: "0755"
    - file_mode: "0644"
    - clean: true
    - makedirs: true

"/opt/papirus-folders/papirus-folders":
  file.managed:
    - require:
      - file: "{{ slsdotpath }}:: papirus-folders"
    - mode: "0755"

"/usr/bin/papirus-folders":
  file.symlink:
    - require:
      - file: "{{ slsdotpath }}:: papirus-folders"
    - target: "/opt/papirus-folders/papirus-folders"

-#}
{%-   endif -%}
{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
