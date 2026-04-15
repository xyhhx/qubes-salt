{%- if grains.id == "dom0" -%}
{%- set vm_name = "provides-split-ssh" -%}

include:
  - dom0.pkgs.qubes-ctap

{%- else -%}
{%- set rpc_service_file = "/etc/qubes-rpc/qubes.SshAgent" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - openssh
      - openssh-askpass
      - qubes-usb-proxy

"{{ slsdotpath }}:: install rpc service":
  file.managed:
    - require:
      - pkg: "{{ slsdotpath }}:: install pkgs"
    - name: "{{ rpc_service_file }}"
    - source: "salt://{{ tpldir | path_join("files/vm", rpc_service_file) }}"
    - user: "root"
    - group: "root"
    - mode: "0755"
    - makedirs: true

{%- endif -%}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
