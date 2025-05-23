# vim: set ts=2 sw=2 sts=2 et :
---

config:
  qvm_defaults:
    netvm: "sys-vpn-ivpn"
    guivm: "dom0"
    audiovm: "sys-audio"

names:
  templates:
    base:
      debian: "on-debian-12-minimal"
      fedora: "on-fedora-41-minimal"
      fedora_xfce: "on-fedora-41-xfce"
      kicksecure: "on-kicksecure-17"
      whonix_gw: "on-whonix-17-gateway"
      whonix_ws: "on-whonix-17-workstation"
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
    fedora_41_xfce: "dvm-fedora-41-xfce"
    firewall_mirageos: "dvm-firewall-mirageos"
    librewolf_f41: "dvm-librewolf-f41"
    trivalent: "dvm-trivalent"
