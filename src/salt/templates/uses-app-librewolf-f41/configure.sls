# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = 'templates.uses-app-librewolf-f41.configure' %}

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

librewolf:
  pkgrepo.managed:
    - baseurl: https://repo.librewolf.net
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://repo.librewolf.net/pubkey.gpg
    - repo_gpgcheck: 1
    - require_in:
      - pkg: librewolf
  pkg.installed:
    - fromrepo: librewolf
    - aggregate: true

psutils:
  pkg.installed:
    - aggregate: true

{% endif %}
