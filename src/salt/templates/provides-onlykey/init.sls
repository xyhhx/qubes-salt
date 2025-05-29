# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "provides-onlykey" %}
{% set base_template = 'fedora-41-minimal' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - actions:
      - clone
      - features
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
      - libusb1-devel
      - pipx
      - gnome-keyring
      - qubes-core-agent-networking
      - qubes-usb-proxy
      - qubes-input-proxy-sender
      - qubes-ctap
  file.managed:
    - names:
      - '/etc/qubes-rpc/onlykey.SshAgent':
        - source: "salt://templates/provides-onlykey/files/onlykey.SshAgent"
      - '/etc/udev/rules.d/49-onlykey.rules':
        - source: "salt://templates/provides-onlykey/files/49-onlykey.rules"
    - user: user
    - group: user
    - mode: "0750"
    - makedirs: true
  cmd.run:
    - names:
      - 'PIPX_GLOBAL_BIN_DIR=/usr/local.orig/bin/ https_proxy=127.0.0.1:8082 pipx install --global onlykey onlykey-agent'
      - 'udevadm control --reload-rules'
      - 'udevadm trigger'
    - use_vt: true
    - require:
      - pkg: '{{ vm_name }}'


{% endif %}
