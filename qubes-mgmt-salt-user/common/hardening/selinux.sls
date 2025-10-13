{%- if grains.os_family | lower == 'redhat' -%}

'qubes-core-agent-selinux':
  pkg.installed

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
