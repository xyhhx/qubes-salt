{%- set vm_name = "provides-net" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - NetworkManager-wifi
      - gnome-keyring
      - network-manager-applet
      - notification-daemon
      - polkit
      - qubes-core-agent-network-manager
      - qubes-core-agent-networking
    - install_recommends: false
    - skip_suggestions: true

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et : 
