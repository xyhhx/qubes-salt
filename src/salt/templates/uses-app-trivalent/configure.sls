# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---
{% set name = 'templates.uses-app-trivalent.configure' %}

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

secureblue:
  pkgrepo.managed:
    - baseurl: https://repo.secureblue.dev
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: https://repo.secureblue.dev/secureblue.gpg
    - require_in:
      - pkg: trivalent

trivalent:
  pkg.installed

psutils:
  pkg.installed

/etc/trivalent/policies/managed/policy.json:
  file.managed:
    - source: salt://templates/uses-app-trivalent/files/policy.json
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true

{% endif %}
