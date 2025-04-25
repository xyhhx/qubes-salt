# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['id'] != 'dom0' %}
# Set vm_name from pillar data
{% set vm_name = pillar.names.templates.providers.ivpn %}
{% set name = "templates.provides-ivpn.configure" %}

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
        - source: 'salt://templates/provides-ivpn/files/dnat-to-ns.service'
      - /etc/systemd/system/dnat-to-ns.path:
        - source: 'salt://templates/provides-ivpn/files/dnat-to-ns.path'
      - /etc/systemd/system/dnat-to-ns-boot.service:
        - source: 'salt://templates/provides-ivpn/files/dnat-to-ns-boot.service'
      - /etc/systemd/system/systemd-resolved.conf.d/override.conf:
        - source: 'salt://templates/provides-ivpn/files/systemd_override.conf'

/opt/ivpn/etc/firewall.sh:
  file.replace:
    - pattern: |-
        \(.*set_dns.*\)
    - repl: |-
        \1,#QUBES OS - specific operation
        systemctl restart systemd-resolved || echo "Error: systemd-resolved" # this line is required for Qubes OS 4.2 (tested on Qubes OS 4.2-RC4)
        /usr/lib/qubes/qubes-setup-dnat-to-ns || echo "Error: failed to run '/usr/lib/qubes/qubes-setup-dnat-to-ns'"
    - ignore_if_missing: true

dnat-to-ns.path:
  service.enabled

dnat-to-ns-boot.service:
  service.enabled

{% endif %}
