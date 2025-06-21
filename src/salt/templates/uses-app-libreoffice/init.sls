{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:uses:libreoffice", "uses-app-libreoffice") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{%- load_yaml as vm_options %}
features:
  - set:
    - menu-items: Alacritty.desktop
    - default-menu-items: >-
        Alacritty.desktop
        libreoffice-base.desktop
        libreoffice-calc.desktop
        libreoffice-draw.desktop
        libreoffice-impress.desktop
        libreoffice-math.desktop
        libreoffice-writer.desktop

{% endload -%}
{{ templatevm(vm_name, options=vm_options) }}

{% else %}

libreoffice:
  pkg.installed

{% endif %}
