{%- set vm_name = "provides-usb" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

include:
  - dom0.pkgs.qubes-ctap

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - qubes-ctap
      - qubes-input-proxy-sender
      - qubes-usb-proxy
    - install_recommends: false
    - skip_suggestions: true

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
