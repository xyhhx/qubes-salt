{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:usb", "provides-usb") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - gnome-keyring
      - qubes-usb-proxy
      - qubes-input-proxy-sender
      - qubes-ctap
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
