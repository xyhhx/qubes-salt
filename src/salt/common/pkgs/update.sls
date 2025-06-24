{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

{#
{%- load_yaml as cmdmap %}
RedHat: 'dnf update -y'
Debian: 'apt update -y && apt upgrade -y'
{% endload -%}
{% set update_cmd = salt["grains.filter_by"](cmdmap) %}

'{{ update_cmd }}':
  cmd.run:
    - use_vt: true
#}

"system update":
  pkg.uptodate:
    - refresh: true

{% endif %}
