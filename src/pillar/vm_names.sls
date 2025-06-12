{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

---
appvms:
  dino: "app-dino"
  libreoffice: "app-libreoffice"
  simple-x: "app-simple-x"
  thunderbird: "app-thunderbird"

dispvms:
  dev: "dvm-dev-f41"
  firewall_mirageos: "dvm-firewall-mirageos"
  fedora_xfce: "dvm-fedora-41-xfce"
  librewolf: "dvm-librewolf-f41"
  sys_net: "dvm-sys-net"
  trivalent: "dvm-trivalent"

sysvms:
  audio: "sys-audio"
  gui: "sys-gui-gpu"
  onlykey: "sys-onlykey"

net:
  eth:
    net: "disp-sys-net-eth"
    firewall_linux: "sys-firewall-linux-eth"
    firewall_mirage: "disp-sys-firewall-mirageos-wifi"
  wifi:
    net: "sys-net-wifi"
    firewall_linux: "sys-firewall-wifi"
    firewall_mirage: "disp-sys-firewall-mirageos-eth"
  vpn:
    ivpn: "sys-vpn-ivpn"
    tor: "sys-whonix"

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
    gpg: "provides-split-gpg"
    gui: "provides-gui"
    ivpn: "provides-ivpn"
    net: "provides-net"
    onlykey: "provides-onlykey"
    usb: "provides-usb"

  uses:
    dino: "uses-app-dino"
    keepassxc: "uses-app-keepassxc"
    libreoffice: "uses-app-libreoffice"
    librewolf: "uses-app-librewolf-f41"
    thunderbird: "uses-app-thunderbird"
    trivalent: "uses-app-trivalent"

  stack:
    dev_f41: "uses-stack-dev-f41"
