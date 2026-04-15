{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - ca-certificates
      - curl
      - jq
      - man-db
      - qubes-core-agent-networking
      - rsync
      - transmission-cli
      - transmission-gtk
      - wget2
    - install_recommends: false
    - skip_suggestions: true

"{{ slsdotpath }}:: add helper scripts":
  file.managed:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - names:
{% for file in [
  "/usr/share/qubes-user/download",
  "/usr/share/qubes-user/fetch-github-release"
] %}
      - "{{ file }}":
        - source: "salt://{{ tpldir | path_join("files/vm", file) }}"
{% endfor %}
    - user: "root"
    - group: "root"
    - mode: "0755"

"{{ slsdotpath }}:: clean scaffold dirs":
  file.directory:
    - require:
      - file: "{{ slsdotpath }}:: add helper scripts"
    - names:
      - "/etc/skel"
      - "/usr/local.orig"
    - clean: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
