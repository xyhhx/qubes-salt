{% if grains.id != 'dom0' %}

{%- import './maps/osfamily.jinja' as pkgs with context -%}

'{{ slsdotpath }}':
  pkg.installed:
    - pkgs: {{ pkgs }}

{% endif %}

{# vim: set syntax=salt.jinja.yaml.yaml ts=2 sw=2 sts=2 et : #}
