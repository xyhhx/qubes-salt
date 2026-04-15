{%- if grains.id != "dom0" -%}

{%- from "./opts.jinja" import tuta_release, download_url, bin_abs_path, bin_install_dir -%}

"{{ slsdotpath }}:: packages installed":
  pkg.installed:
    - pkgs:
      - fuse
      - fuse-libs
      - qubes-core-agent-networking

"{{ slsdotpath }}:: prepare app parent dir":
  file.directory:
    - require:
      - pkg: "{{ slsdotpath }}:: packages installed"
    - name: "{{ bin_install_dir }}"
    - user: "root"
    - group: "root"
    - dir_mode: "0755"
    - file_mode: "0755"
    - makedirs: true

"{{ slsdotpath }}:: download appimage":
  cmd.run:
    - require:
      - file: "{{ slsdotpath }}:: prepare app parent dir"
    - name: |
        qvm-run-vm @dispvm:dvm-fetch -- "/usr/share/qubes-user/download {{ download_url }} {{ tuta_release.checksum }}" > {{ bin_abs_path }}
    - use_vt: true
    - unless:
      - fun: file.check_hash
        args:
          - "{{ bin_abs_path }}"
          - "sha256={{ tuta_release.checksum }}"

"{{ bin_abs_path }}":
  file.managed:
    - require:
      - cmd: "{{ slsdotpath }}:: download appimage"
    - user: "root"
    - group: "root"
    - mode: "0755"
    - checksum: "sha256:{{ tuta_release.checksum }}"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
