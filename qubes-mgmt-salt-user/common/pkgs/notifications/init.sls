{% if grains.id != 'dom0' %}

{%- import './maps/osfamily.jinja' as pkgs with context -%}

'{{ slsdotpath }}:pkg.installed':
  pkg.installed:
    - pkgs: {{ pkgs }}

'{{ slsdotpath }}:pkg.purged':
  pkg.purged:
    - pkgs:
      - notification-daemon

{% endif %}

{# vim: set syntax=salt.jinja.yaml.yaml ts=2 sw=2 sts=2 et : #}
