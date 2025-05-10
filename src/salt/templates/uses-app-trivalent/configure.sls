# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = 'templates.uses-app-trivalent.configure' %}

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

secureblue:
  pkgrepo.managed:
    - baseurl: https://repo.secureblue.dev
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: https://repo.secureblue.dev/secureblue.gpg
    - require_in:
      - pkg: trivalent

trivalent-copr:
  pkgrepo.managed:
    - copr: secureblue/trivalent
    - require_in:
      - pkg: trivalent-subresource-filter

trivalent:
  pkg.installed:
    - fromrepo: secureblue
    - aggregate: true

trivalent-subresource-filter:
  pkg.installed:
    - aggregate: true

psutils:
  pkg.installed:
    - aggregate: true

'{{ name }}':
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - names:
      - /etc/librewolf/policies/qubes-mgmt-salt-user.json:
        - source: salt://templates/uses-app-librewolf-f41/files/policy.json

{% endif %}
