{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - qrencode
      - keepassxc

"{{ slsdotpath }}:: add usrlocal skeleton dir":
  file.directory:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: "/usr/local.orig/share/keepassxc"
    - user: "root"
    - group: "root"
    - dir_mode: "0755"
    - file_mode: "0644"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
