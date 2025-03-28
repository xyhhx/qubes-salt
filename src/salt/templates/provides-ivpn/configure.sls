# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.templates.providers.ivpn %}

'{{ vm_name }}__pkgrepo.managed':
  pkgrepo.managed:
    - mirrorlist: "https://repo.ivpn.net/stable/fedora/generic/ivpn.repo"

'{{ vm_name }}__pkg.installed':
  pkg.installed:
    - pkgs:
      - ivpn-ui
      - ivpn
    - refresh: true
    - skip_suggestions: true
    - install_recommends: false
