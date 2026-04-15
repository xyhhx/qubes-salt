{%- if grains.id != "dom0" -%}

{%- load_yaml as repo -%}
key: "/usr/share/keyrings/ivpn-archive-keyring.asc"
url: "https://repo.ivpn.net/stable/debian"
{%- endload -%}

include:
  - common.hardening.kicksecure

"{{ slsdotpath }}:: install pkg repos":
  pkgrepo.managed:
    - require:
      - sls: common.hardening.kicksecure
    - name: "deb [arch=amd64 signed-by={{ repo.key }}] {{ repo.url }} ./generic main"
    - file: "/etc/apt/sources.list.d/ivpn.list"
    - key_url: "salt://{{ tpldir | path_join( "files/vm", repo.key ) }}"

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - require:
      - pkgrepo: "{{ slsdotpath }}:: install pkg repos"
    - pkgs:
      - libasound2t64
      - ivpn
      - ivpn-ui
      - qubes-core-agent-networking
    - install_recommends: false

"{{ slsdotpath }}:: confs":
  file.managed:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true
    - names:
      - "/etc/qubes-bind-dirs.d/30-ivpn.conf":
        - source: "salt://{{ tpldir | path_join("files/vm", "etc/qubes-bind-dirs.d/30-ivpn.conf") }}"
      - "/etc/qubes/qubes-firewall.d/30-leak-prevent.sh":
        - source: "salt://{{ tpldir | path_join("files/vm", "etc/qubes/qubes-firewall.d/30-leak-prevent.sh") }}"
        - mode: "0750"
      - "/usr/lib/ivpn/ivpn-autoconnect.sh":
        - source: "salt://{{ tpldir | path_join("files/vm", "usr/lib/ivpn/ivpn-autoconnect.sh") }}"
        - mode: "0755"
{% for file in [
  "/etc/systemd/system/dnat-to-ns.service",
  "/etc/systemd/system/dnat-to-ns.path",
  "/etc/systemd/system/dnat-to-ns-boot.service",
  "/etc/systemd/system/ivpn-autoconnect.service",
  "/etc/systemd/systemd-resolved-conf.d/override-restart-interval.conf",
] %}
      - "{{ file }}":
        - source: "salt://{{ tpldir | path_join("files/vm", file) }}"
{% endfor %}

"{{ slsdotpath }}:: enable services":
  service.enabled:
    - require:
      - file: "{{ slsdotpath }}:: confs"
    - names:
      - "ivpn-autoconnect.service"
      - "dnat-to-ns.path"
      - "dnat-to-ns-boot.service"

"{{ slsdotpath }}:: directories":
  file.directory:
    - require:
      - service: "{{ slsdotpath }}:: enable services"
    - names:
      - "/rw/bind-dirs/etc/opt/ivpn/mutable"
      - "/usr/lib/ivpn"
    - makedirs: true
    - dir_mode: "0755"
    - recurse:
      - mode

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
