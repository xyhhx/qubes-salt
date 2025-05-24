# vim: set ts=2 sw=2 sts=2 et :
---

config:
  versions:
    debian: 12
    fedora: 41
    kicksecure: 17
    whonix: 17
  qvm_defaults:
    netvm: "sys-vpn-ivpn"
    guivm: "dom0"
    audiovm: "sys-audio"

names:
  templates:
    base:
      debian: "debian-{{ debian_version }}"
      debian_minimal: "debian-{{ debian_version }}-minimal"
      fedora: "fedora-{{ fedora_version }}"
      fedora_minimal: "fedora-{{ fedora_version }}-minimal"
      fedora_xfce: "fedora-{{ fedora_version }}-xfce"
      whonix_gw: "whonix-gateway-{{ whonix_version }}"
      whonix_ws: "whonix-workstation-{{ whonix_version }}"
    oses:
      debian: "on-debian-{{ debian_version }}-minimal"
      fedora: "on-fedora-{{ fedora_version }}-minimal"
      fedora_xfce: "on-fedora-{{ fedora_version }}-xfce"
      kicksecure: "on-kicksecure-{{ kicksecure_version }}"
      whonix_gw: "on-whonix{{ whonix_version }}-gateway"
      whonix_ws: "on-whonix{{ whonix_version }}-workstation"
    apps:
      keepassxc: "uses-app-keepassxc"
      libreoffice: "uses-app-libreoffice"
      librewolf: "uses-app-librewolf"
      simplex: "uses-app-simple-x"
      thunderbird: "uses-app-thunderbird"
      trivalent: "uses-app-trivalent"
    providers:
      appimage: "provides-appimage"
      audio: "provides-audio"
      docker: "provides-docker"
      firewall_linux: "provides-firewall-linux"
      firewall_mirageos: "provides-firewall-mirageos"
      flatpak: "provides-flatpak"
      ivpn: "provides-ivpn"
      net: "provides-net"
      onlykey: "provides-onlykey"
      split_gpg: "provides-split-gpg"
      usb: "provides-usb"
    stacks:
      dev: "uses-stack-dev-f41" # (default)
      dev_f41: "uses-stack-dev-f41"

  appvms:
    app_libreoffice: "app-libreoffice"
    app_simple_x: "app-simple-x"
    app_thunderbird: "app-thunderbird"
    sys_audio: "sys-audio"
    sys_onlykey: "sys-onlykey"
    sys_vpn_ivpn: "sys-vpn-ivpn"
    sys_whonix: "sys-whonix"

  dispvms:
    sys_firewall_mirageos_eth: "disp-sys-firewall-mirageos-eth"
    sys_firewall_mirageos_wifi: "disp-sys-firewall-mirageos-wifi"
    dev_f41: "dvm-dev-f41"
    fedora_41_xfce: "dvm-fedora-{{ fedora_version }}-xfce"
    firewall_mirageos: "dvm-firewall-mirageos"
    librewolf_f41: "dvm-librewolf-f41"
    trivalent: "dvm-trivalent"
