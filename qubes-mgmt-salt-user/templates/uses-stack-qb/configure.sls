{%- if grains.id != "dom0" -%}
{%- set ssh_known_hosts_file = "/etc/ssh/ssh_known_hosts" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      # minimal template deps
      - qubes-core-agent-networking
      - qubes-core-agent-passwordless-root
      # builder deps
      - asciidoc
      - createrepo_c
      - devscripts
      - git
      - gnupg2
      - m4
      - openssl
      - python3-click
      - python3-jinja2-cli
      - python3-lxml
      - python3-packaging
      - python3-pathspec
      - python3-pyyaml
      - rb_libtorrent-examples
      - reprepro
      - rpm
      - rpm-sign
      - rsync
      - sequoia-chameleon-gnupg
      - sequoia-sq
      - sequoia-sqv
      - tree
      - vim-common

"{{ slsdotpath }}:: populate known_hosts":
  file.managed:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: "{{ ssh_known_hosts_file }}"
    - source: "salt://{{ tpldir | path_join("files/vm", ssh_known_hosts_file) }}"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
