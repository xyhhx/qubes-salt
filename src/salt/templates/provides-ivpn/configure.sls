# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% set vm_name = pillar.names.templates.providers.ivpn %}

'{{ vm_name }}__pkgrepo.managed':
  pkgrepo.managed:
    - humanname: "IVPN Software"
    - baseurl: "https://repo.ivpn.net/stable/fedora/generic/$basearch"
    - key_url: "https://repo.ivpn.net/stable/fedora/generic/repo.gpg"
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
