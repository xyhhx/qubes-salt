# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = "common.pkgs.update" %}

pkg.upgrade:
  module.run:
    - refresh: true
