# vim: set ts=2 sw=2 sts=2 et :
---
names:
  templates:
    base:
      debian: "on-debian-12-minimal"
      kicksecure: "on-kicksecure-17"
      fedora: "on-fedora-41-minimal"
      fedora_xfce: "on-fedora-41-xfce"
    apps:
      trivalent: "uses-app-trivalent"
    providers:
      audio: "provides-audio"
      browsers_kicksecure: "provides-browsers-on-kicksecure"
      ivpn: "provides-ivpn"
      mirageos_firewall:  "provides-mirageos-firewall"
      net: "provides-net"
      usb: "provides-usb"
    stacks:
      dev: "uses-stack-dev"

  appvms:
  dispvms:
    trivalent: "dvm-trivalent"
    browsers_kicksecure: "dvm-browsers-kicksecure"
    firewall_wifi_mirageos: "disp-sys-firewall-mirageos-wifi"
    sys_net_lan: "disp-sys-net-lan"
  standalones:
  sysvms:
    firewall_lan: "sys-firewall-lan"
    firewall_mirageos_lan: "sys-firewall-mirageos-lan"
    firewall_mirageos_wifi: "sys-firewall-mirageos-wifi"
    firewall_wifi: "sys-firewall-wifi"
    net_lan: "sys-net-lan"
    net_wifi: "sys-net-wifi"
    onlykey: "sys-onlykey"
    vpn_ivpn: "sys-vpn-ivpn"
  dom0_user: "whomst"
