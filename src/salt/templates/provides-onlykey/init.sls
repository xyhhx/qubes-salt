{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:onlykey", "provides-onlykey") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - gnome-keyring
      - libusb1-devel
      - pipx
      - qubes-core-agent-networking
      - qubes-ctap
      - qubes-input-proxy-sender
      - qubes-usb-proxy
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
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
  cmd.run:
    - names:
      - 'pipx install --global onlykey onlykey-agent':
        - env:
            - PIPX_GLOBAL_BIN_DIR: "/usr/local.orig/bin/"
            - https_proxy: "127.0.0.1:8082"
        - unless:
          - 'which onlykey'
          - 'which onlykey-agent'
      - 'udevadm control --reload-rules && udevadm trigger':
        - bg: true
    - use_vt: true
    - require:
      - pkg: '{{ vm_name }}'
  service.enabled:
    - names:
      - onlykey-ssh-agent.service
      - onlykey-ssh-agent.socket

{% endif %}
