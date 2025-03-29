# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

# Set vm_name from pillar data
{% set vm_name = pillar.names.templates.providers.ivpn %}

'{{ vm_name }}__pkgrepo.managed':
  pkgrepo.managed:
    - humanname: "IVPN Software"
    - baseurl: "https://repo.ivpn.net/stable/fedora/generic/$basearch"
    - key_url: "https://repo.ivpn.net/stable/fedora/generic/repo.gpg"
    - gpgcheck: true
    - require_in:
      - ivpn
      - ivpn-ui

'{{ vm_name }}__pkg.installed':
  pkg.installed:
    - pkgs:
      - ivpn
      - ivpn-ui
    - skip_suggestions: true
    - install_recommends: false

/etc/systemd/system/dnat-to-ns.service:
  file.managed:
    - source: 'salt://templates/provides-ivpn/files/dnat-to-ns.service'
    - mode: 0640
    - owner: root
    - group: root

/etc/systemd/system/dnat-to-ns.path:
  file.managed:
    - source: 'salt://templates/provides-ivpn/files/dnat-to-ns.path'
    - mode: 0640
    - owner: root
    - group: root

/etc/systemd/system/dnat-to-ns-boot.service:
  file.managed:
    - source: 'salt://templates/provides-ivpn/files/dnat-to-ns-boot.service'
    - mode: 0640
    - owner: root
    - group: root

/etc/systemd/system/systemd-resolved.conf.d/override.conf:
  file.managed:
    - source: 'salt://templates/provides-ivpn/files/systemd_override.conf'
    - mode: 0640
    - owner: root
    - group: root
    - makedirs: true

dnat-to-ns.path:
  service.enabled

dnat-to-ns-boot.service:
  service.enabled

{% endif %}
