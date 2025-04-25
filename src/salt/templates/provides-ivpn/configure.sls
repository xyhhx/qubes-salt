# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['id'] != 'dom0' %}
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
      - /etc/systemd/system/dnat-to-ns.service:
        - source: '{{ file_dir }}/dnat-to-ns.service'
      - /etc/systemd/system/dnat-to-ns.path:
        - source: '{{ file_dir }}/dnat-to-ns.path'
      - /etc/systemd/system/dnat-to-ns-boot.service:
        - source: '{{ file_dir }}/dnat-to-ns-boot.service'
      - /etc/systemd/system/systemd-resolved.conf.d/override.conf:
        - source: '{{ file_dir }}/systemd_override.conf'

/opt/ivpn/etc/firewall.sh:
  file.patch:
    - source: '{{ file_dir }}/firewall.patch'

dnat-to-ns.path:
  service.enabled

dnat-to-ns-boot.service:
  service.enabled

{% endif %}
