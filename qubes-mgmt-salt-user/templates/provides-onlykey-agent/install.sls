{%- set vm_name = 'provides-onlykey-agent' -%}
{%- set base_template = 'fedora-43-minimal' -%}

{%- if grains.id == 'dom0' -%}

{%- from 'utils/macros/create_templatevm.sls' import templatevm -%}
{{ templatevm(vm_name, base_template=base_template) }}

{%- else -%}

'{{ slsdotpath }}:: pkg.installed':
  pkg.installed:
    - pkgs:
      - libusb1-devel
      - qubes-ctap
      - qubes-usb-proxy
      - systemd-devel

'{{ slsdotpath }}:: pip venv packages':
  virtualenv.managed:
    - require:
      - pkg: '{{ slsdotpath }}:: pkg.installed'
    - name: '/var/opt/onlykey'
    - pip_pkgs:
      - onlykey
      - onlykey-agent
      - 'setuptools==78.1.1'
    - proxy: '127.0.0.1:8082'
    - use_vt: true

'{{ slsdotpath }}:: udev rules':
  file.managed:
    - require:
      - virtualenv: '{{ slsdotpath }}:: pip venv packages'
    - name: '/etc/udev/rules.d/30-onlykey.rules'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

'{{ slsdotpath }}:: reload udev':
  cmd.run:
    - onchanges:
      - file: '{{ slsdotpath }}:: udev rules'
    - name: 'udevadm control --reload-rules && udevadm trigger'
    - bg: true
    - use_vt: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
