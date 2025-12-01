{%- set vm_name = 'provides-onlykey-agent' -%}
{%- set base_template = 'fedora-43-minimal' -%}

{%- if grains.id == 'dom0' -%}

{%- from 'utils/macros/create_templatevm.sls' import templatevm -%}
{{ templatevm(vm_name, base_template=base_template) }}

{%- else -%}

{%- from 'utils/user_info.jinja' import user with context -%}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - gnome-keyring
      - libusb1-devel
      - pipx
      - qubes-ctap
      - qubes-usb-proxy
      - systemd-devel
  file.managed:
    - names:
{% for file in [
  '/etc/udev/rules.d/30-onlykey.rules',
  '/etc/systemd/system/onlykey-ssh-agent.service',
  '/etc/systemd/system/onlykey-ssh-agent.socket'
] %}
      - '{{ file }}':
        - source: 'salt://{{ tpldir ~ '/files/vm' ~ file }}'
{% endfor %}
      - '/etc/qubes-rpc/qubes.SshAgent':
        - source: 'salt://{{ tpldir }}/files/vm/etc/qubes-rpc/qubes.SshAgent'
        - mode: '0755'
      - '/etc/environment.d/30-onlykey-ssh.conf':
        - source: 'salt://{{ tpldir }}/files/vm/etc/environment.d/30-onlykey-ssh.conf.j2'
        - defaults:
            user: 'user'
        - context:
            user: '{{ user }}'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
    - template: 'jinja'
  cmd.run:
    - names:
      - 'pipx install --global onlykey onlykey-agent':
        - env:
            PIPX_GLOBAL_BIN_DIR: "/opt"
            https_proxy: "127.0.0.1:8082"
        - creates:
          - '/opt/pipx/venvs/onlykey'
          - '/opt/pipx/venvs/onlykey-agent'
      - 'udevadm control --reload-rules && udevadm trigger':
        - bg: true
        - onchanges:
          - file: '{{ vm_name }}'
    - use_vt: true
  service.enabled:
    - names:
      - 'onlykey-ssh-agent.service'
      - 'onlykey-ssh-agent.socket'

'/etc/skel/.config/onlykey/ssh-agent.conf':
  file.managed:
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true
    - contents: ""

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
