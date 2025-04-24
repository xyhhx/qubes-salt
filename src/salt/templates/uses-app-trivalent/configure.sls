# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

secureblue:
  pkgrepo.managed:
    - baseurl: https://repo.secureblue.dev
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: https://repo.secureblue.dev/secureblue.gpg

trivalent:
  pkg.installed

/opt/trivalent/policies/managed/policy.json:
  file.managed:
    - source: salt://templates/uses-app-trivalent/files/policy.json
    - user: root
    - group: root
    - mode: '0640'
    - makedirs: true

{% endif %}
