{%- if grains.id != "dom0" -%}

{%- set overrides_file = "/etc/firefox/defaults/pref/phoenix-overrides.js" -%}

include:
  - common.pkgs.dnf-plugins-core

"{{ slsdotpath }}:: install pkgrepos":
  pkgrepo.managed:
    - name: "celenity"
    - copr: "celenity/copr"

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - require:
      - pkgrepo: "{{ slsdotpath }}:: install pkgrepos"
    - pkgs:
      - firefox
      - phoenix
      - qubes-ctap
      - qubes-core-agent-networking

"{{ slsdotpath }}:: install phoenix overrides":
  file.managed:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: "{{ overrides_file }}"
    - source: "salt://{{ tpldir | path_join("files/vm", overrides_file) }}"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

"{{ slsdotpath }}:: configure qubes-ctapproxy":
  cmd.run:
    - names:
      - "systemctl disable qubes-ctapproxy@sys-usb.service"
      - "systemctl enable qubes-ctapproxy@disp-sys-usb.service":
        - creates: "/etc/systemd/system/multi-user.target.wants/qubes-ctapproxy@disp-sys-usb.service"

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
