{%- if grains.id != "dom0" -%}
{%- from "./opts.jinja" import builder_persistent_dir -%}

"{{ slsdotpath }}:: configure persistent build dir":
  file.managed:
    - names:
      - "/rw/config/qubes-bind-dirs.d/builder.conf":
        - contents: |
            binds+=({{ builder_persistent_dir }})
        - mode: "0644"
      - "/rw/config/rc.local.d/50-mount-build-dir.conf":
        - contents: |
            mount {{ builder_persistent_dir }} -o dev,suid,remount
        - mode: "0755"
    - user: "root"
    - group: "root"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
