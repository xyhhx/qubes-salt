{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:uses:dino", "uses-app-dino") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{%- load_yaml as vm_options %}
features:
  - set:
    - menu-items: Alacritty.desktop im.dino.Dino.desktop
    - default-menu-items: Alacritty.desktop im.dino.Dino.desktop
{% endload -%}
{{ templatevm(vm_name, options=vm_options) }}

{% else %}

dino:
  pkg.installed

{% endif %}
