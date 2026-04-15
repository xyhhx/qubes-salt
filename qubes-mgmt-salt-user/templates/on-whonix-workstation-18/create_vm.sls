{%- if grains.id == "dom0" -%}
{%- set vm_name = "on-whonix-workstation-18" -%}
{%- set base_template = "whonix-workstation-18" -%}

{%- load_yaml as options -%}
features:
  - disable:
    - selinux
  - set:
    - default-menu-items: {{ [

  "Alacritty.desktop"
  "anondist-torbrowser_update.desktop",
  "janondisttorbrowser.desktop",
  "systemcheck.desktop",
  "thunar.desktop",

] | join(" " ) }}

tags:
  - add:
    - on-kicksecure
    - whonix-updatevm
{%- endload -%}

{%- from "utils/macros/create_templatevm.sls" import templatevm -%}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
