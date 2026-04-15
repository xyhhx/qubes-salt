{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}:: install pkgs":
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

"{{ slsdotpath }}: remove unnecessary firmware":
  pkg.purged:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - pkgs:
      - amd-audio-firmware
      - amd-gpu-firmware
      - intel-audio-firmware
      - intel-gpu-firmware
      - nvidia-gpu-firmware

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
