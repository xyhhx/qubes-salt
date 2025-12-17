{%- set vm_name = "uses-app-tuta" -%}
{%- set base_template = "fedora-43-minimal" -%}

{%- if grains.id == 'dom0' -%}
{%- load_yaml as vm_options -%}
features:
  - set:
    - default-menu-items: Alacritty.desktop tutanota-desktop.desktop
{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=vm_options) }}

{%- else -%}

{#- TODO: Move some of this to pillar data (including pillar.example) -#}
{%- set release_number = '335.260310.0' -%}
{%- set appimage = 'tuta-desktop-linux.AppImage' -%}
{%- set download_url = 'https://github.com/tutao/tutanota/releases/download/tutanota-desktop-release-' ~ release_number ~ '/' ~ 'tutanota-desktop-linux.AppImage' -%}
{%- set install_dir = '/opt/tuta-desktop-linux' -%}
{%- set appimage_full_path = install_dir | path_join(appimage) -%}
{%- set checksum = '3eb82edd6b0607f7761f7497ff222e79925b8345d755ff6dd44103e26cf88792' -%}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - fuse
      - fuse-libs
      - qubes-core-agent-networking

'{{ install_dir }}':
  file.directory:
    - user: 'root'
    - group: 'root'
    - dir_mode: '0755'
    - file_mode: '0755'
    - makedirs: true

'{{ slsdotpath }}: download appimage':
  cmd.run:
    - name: "qvm-run-vm @dispvm:dvm-fetch -- '/usr/share/qubes-user/download {{ download_url }} {{ checksum }}' > {{ appimage_full_path }}"
    - require:
      - file: '{{ install_dir }}'

'{{ appimage_full_path }}':
  file.managed:
    - user: 'root'
    - group: 'root'
    - mode: '0755'
    - checksum: 'sha256:{{ checksum}}'
    - require:
      - cmd: '{{ slsdotpath }}: download appimage'

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
