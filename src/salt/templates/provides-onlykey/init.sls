{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}


{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:onlykey") -%}
{%- set base_template = salt["pillar.get"]("base_templates:fedora:minimal") -%}

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
      - '/etc/qubes-rpc/qubes.SshAgent':
        - source: 'salt://templates/provides-onlykey/files/qubes.SshAgent'
        - mode: '0755'
      - '/etc/udev/rules.d/49-onlykey.rules':
        - source: 'salt://templates/provides-onlykey/files/49-onlykey.rules'
      - '/etc/environment.d/49-onlykey-ssh.conf':
        - source: 'salt://templates/provides-onlykey/files/49-onlykey-ssh.conf'
      - '/etc/systemd/system/onlykey-ssh-agent.service':
        - source: 'salt://templates/provides-onlykey/files/onlykey-ssh-agent.service'
      - '/etc/systemd/system/onlykey-ssh-agent.socket':
        - source: 'salt://templates/provides-onlykey/files/onlykey-ssh-agent.socket'
      - '/etc/skel/.config/onlykey/ssh-agent.conf':
        - contents: ''
          user: root
          group: root
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
  cmd.run:
    - names:
      - 'PIPX_GLOBAL_BIN_DIR=/usr/local.orig/bin/ https_proxy=127.0.0.1:8082 pipx install --global onlykey onlykey-agent'
      - 'udevadm control --reload-rules'
      - 'udevadm trigger'
    - use_vt: true
    - require:
      - pkg: '{{ vm_name }}'
  service.enabled:
    - names:
      - onlykey-ssh-agent.service
      - onlykey-ssh-agent.socket

{% endif %}
