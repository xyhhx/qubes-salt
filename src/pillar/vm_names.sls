{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

vm_names:
  appvms:
    dino: "app-dino"
    libreoffice: "app-libreoffice"
    thunderbird: "app-thunderbird"
    vault_onlykey: "vault-onlykey"
    vault_pgp: "vault-pgp"

  dispvms:
    dev: "dvm-dev"
    fedora_xfce: "dvm-fedora-xfce"
    firewall_mirageos: "dvm-firewall-mirageos"
    librewolf: "dvm-librewolf"
    salt_mgmt: "dvm-salt-mgmt"
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
      firewall_mirage: "disp-sys-firewall-mirageos-eth"
    wifi:
      net: "sys-net-wifi"
      firewall_linux: "sys-firewall-wifi"
      firewall_mirage: "disp-sys-firewall-mirageos-wifi"
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
      gpg2: "provides-split-gpg2"
      guivm: "provides-guivm"
      ivpn: "provides-ivpn"
      net: "provides-net"
      onlykey: "provides-onlykey"
      usb: "provides-usb"

    uses:
      dino: "uses-app-dino"
      keepassxc: "uses-app-keepassxc"
      libreoffice: "uses-app-libreoffice"
      librewolf: "uses-app-librewolf"
      onlykey: "uses-app-onlykey"
      thunderbird: "uses-app-thunderbird"
      trivalent: "uses-app-trivalent"

    stack:
      dev: "uses-stack-dev"
