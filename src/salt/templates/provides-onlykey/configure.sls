# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

'provides-onlykey__pkg.installed':
  pkg.installed:
    - pkgs:
      - libudev-devel
      - libusb1-devel
      - pipx
      - gnome-keyring
      - qubes-core-agent-networking
      - qubes-usb-proxy
      - qubes-input-proxy-sender
      - qubes-ctap
      - ykpers
      - yubikey-personlization-gui
    - skip_suggestions: true
    - install_recommends: false

/etc/qubes-rpc/onlykey.SshAgent:
  file.managed:
    - source: salt://templates/provides-onlykey/files/onlykey.SshAgent
    - user: user
    - group: user
    - mode: 0750

/etc/udev/rules.d/49-onlykey.rules:
  file.managed:
    - source: salt://templates/provides-onlykey/files/49-onlykey.rules
    - user: user
    - group: user
    - mode: 0750

'HTTPS_PROXY=127.0.0.1:8082 pipx install onlykey onlykey-agent':
  cmd.run:
    - runas: user

'udevadm control --reload-rules':
  cmd.run

'udevadm trigger':
  cmd.run
