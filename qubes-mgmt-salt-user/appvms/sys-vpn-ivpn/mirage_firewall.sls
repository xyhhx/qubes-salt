{%- if grains.id == "dom0" -%}

{%- from "./opts.jinja" import mirage_fw -%}

{%- from 'utils/macros/create-standalone-mirageos-firewall.sls' import create_standalone_mirageos_firewall -%}
{{ create_standalone_mirageos_firewall(name=mirage_fw.name, netvm=mirage_fw.netvm) }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
