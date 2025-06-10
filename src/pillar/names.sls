# vim: set ts=2 sw=2 sts=2 et :
---

dispvms:
  dev: "dvm-dev-f41"
  firewall_wifi_mirageos: "disp-sys-firewall-mirageos-wifi"
  fedora_xfce: "dvm-fedora-41-xfce"
  librewolf: "dvm-librewolf-f41"
  sys_net_lan: "disp-sys-net-lan"
  trivalent: "dvm-trivalent"

appvms:
  libreoffice: "app-libreoffice"
  simple-x: "app-simple-x"
  thunderbird: "app-thunderbird"

sysvms:
  audio: "sys-audio"
  gui: "sys-gui-gpu"
  onlykey: "sys-onlykey"
  vpn: "sys-vpn-ivpn"
  whonix: "sys-whonix"
  firewall_lan: "sys-firewall-lan"
  firewall_mirageos_lan: "sys-firewall-mirageos-lan"
  firewall_mirageos_wifi: "sys-firewall-mirageos-wifi"
  firewall_wifi: "sys-firewall-wifi"
  net_lan: "sys-net-lan"
  net_wifi: "sys-net-wifi"

templates:
  os:
    debian: "on-debian-12-minimal"
    fedora: "on-fedora-41-minimal"
    fedora_xfce: "on-fedora-41-xfce"
    kicksecure: "on-kicksecure-17"
    whonix_gw: "on-whonix-17-gateway"
    whonix_ws: "on-whonix-17-workstation"

  providers:
    appimage: "provides-appimage"
    audio: "provides-audio"
    docker: "provides-docker"
    firewall_linux: "provides-firewall-linux"
    firewall_mirageos: "provides-firewall-mirageos"
    flatpak: "provides-flatpak"
    gui: "provides-gui"
    ivpn: "provides-ivpn"
    net: "provides-net"
    onlykey: "provides-onlykey"
    gpg: "provides-gpg"
    usb: "provides-usb"

  uses:
    keepassxc: "uses-app-keepassxc"
    libreoffice: "uses-app-libreoffice"
    librewolf: "uses-app-librewolf-f41"
    simplex: "uses-app-simple-x"
    thunderbird: "uses-app-thunderbird"
    trivalent: "uses-app-trivalent"

  stack:
    dev_f41: "uses-stack-dev-f41"
