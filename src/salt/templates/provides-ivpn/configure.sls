# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}
# Set vm_name from pillar data
{% set vm_name = pillar.names.templates.providers.ivpn %}
{% set name = "templates.provides-ivpn.configure" %}
{% set file_dir = 'salt://templates/provides-ivpn/files' %}

include:
  - common.https_proxy

ivpn-repo:
  pkgrepo.managed:
    - baseurl: "https://repo.ivpn.net/stable/fedora/generic/$basearch"
    - type: "rpm"
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: "https://repo.ivpn.net/stable/fedora/generic/repo.gpg"

'{{ name }}':
  pkg.installed:
    - pkgs:
      - ivpn
      - ivpn-ui
      - patch
      - procps-ng
    - skip_suggestions: true
    - install_recommends: false
    - refresh: true
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
