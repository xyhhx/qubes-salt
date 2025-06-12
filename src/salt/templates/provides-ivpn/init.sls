{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---

{% set name = "templates.provides-ivpn.init" %}
{% set vm_name = salt["pillar.get"]("vm_names:templates:providers:ivpn") %}
{% set base_template = 'fedora-41-minimal' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

include:
  - common.https_proxy

'{{ name }}':
  pkgrepo.managed:
    - baseurl: "https://repo.ivpn.net/stable/fedora/generic/$basearch"
    - type: "rpm"
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: "https://repo.ivpn.net/stable/fedora/generic/repo.gpg"
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
    - source: '{{ file_dir }}/firewall.patch'

/rw/bind-dirs/etc/opt/ivpn/mutable:
  file.directory:
    - makedirs: true

{% endif %}
