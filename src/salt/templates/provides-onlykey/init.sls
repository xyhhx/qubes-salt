# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "provides-onlykey" %}
{% set base_template = 'fedora-41-minimal' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - actions:
      - clone
      - prefs
      - tags
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
    - features:
      - enable:
        - service.updates-proxy-setup

{% else %}

'{{ vm_name }}':
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
      - qubes-u2f
      - ykpers
      - yubikey-personlization-gui
    - skip_suggestions: true
    - install_recommends: false
  file.managed:
    - names:
      - '/etc/qubes-rpc/onlykey.SshAgent':
        - source: "salt://templates/provides-onlykey/files/onlykey.SshAgent"
      - '/etc/udev/rules.d/49-onlykey.rules':
        - source: "salt://templates/provides-onlykey/files/49-onlykey.rules"
    - user: user
    - group: user
    - mode: "0750"
  cmd.run:
    - names:
      - 'HTTPS_PROXY=127.0.0.1:8082 pipx install onlykey onlykey-agent'
      - 'udevadm control --reload-rules'
      - 'udevadm trigger'
    - use_vt: true
    - runas: user


{% endif %}
