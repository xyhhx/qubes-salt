{%- set vm_name = "provides-net" -%}
{%- set base_template = "fedora-43-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - NetworkManager-wifi
      - gnome-keyring
      - iwlwifi-dvm-firmware
      - iwlwifi-mld-firmware
      - iwlwifi-mvm-firmware
      - linux-firmware
      - network-manager-applet
      - polkit
      - qubes-core-agent-network-manager
      - qubes-core-agent-networking
    - install_recommends: false
    - skip_suggestions: true

'{{ vm_name }}: remove unnecessary firmware':
  pkg.purged:
    - pkgs:
      - amd-audio-firmware
      - amd-gpu-firmware
      - intel-audio-firmware
      - intel-gpu-firmware
      - nvidia-gpu-firmware

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
