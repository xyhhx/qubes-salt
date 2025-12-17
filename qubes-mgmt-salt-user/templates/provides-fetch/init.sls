{%- set vm_name = "provides-fetch" -%}
{%- set base_template = "fedora-43-minimal" -%}

{% if grains.id == 'dom0' %}
{%- load_yaml as options -%}
prefs:
  - audiovm: ""
  - management_dispvm: "dvm-fedora-43-xfce"
{%- endload -%}
{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{% else %}

'{{ vm_name }}':
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
  file.managed:
    - name: '/usr/share/qubes-user/download'
    - source: 'salt://{{ tpldir }}/files/download'
    - user: 'root'
    - group: 'root'
    - mode: '0755'

'/etc/skel':
  file.directory:
    - clean: true

'/usr/local.orig':
  file.directory:
    - clean: true

{% endif %}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
