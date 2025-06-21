{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:ivpn", "provides-ivpn") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

include:
  - common.https_proxy

'{{ vm_name }}':
  pkgrepo.managed:
    - baseurl: "https://repo.ivpn.net/stable/fedora/generic/$basearch"
    - type: "rpm"
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: "https://repo.ivpn.net/stable/fedora/generic/repo.gpg"
    - require:
      - sls: common.https_proxy
  pkg.installed:
    - pkgs:
      - ivpn
      - ivpn-ui
      - patch
      - procps-ng
    - skip_suggestions: true
    - install_recommends: false
  file.managed:
    - user: root
    - group: root
    - mode: '0640'
    - makedirs: true
    - names:
      - /etc/qubes-bind-dirs.d/50_user.conf:
        - contents: |-
            binds+=( '/etc/opt/ivpn/mutable' )

/opt/ivpn/etc/firewall.sh:
  file.patch:
    - source: 'salt://templates/provides-ivpn/files/firewall.patch'

/rw/bind-dirs/etc/opt/ivpn/mutable:
  file.directory:
    - makedirs: true

{% endif %}
