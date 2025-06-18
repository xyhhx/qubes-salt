{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:uses:keepassxc", "uses-app-keepassxc") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{%- load_yaml as vm_options %}
features:
  - set:
    - menu-items: Alacritty.desktop org.keepassxc.KeePassXC.desktop
    - default-menu-items: Alacritty.desktop org.keepassxc.KeePassXC.desktop
{% endload -%}
{{ templatevm(vm_name, options=vm_options) }}

{% else %}

qubes-usb-proxy:
  pkg.installed

keepassxc:
  pkg.installed

qrencode:
  pkg.installed

{% endif %}
