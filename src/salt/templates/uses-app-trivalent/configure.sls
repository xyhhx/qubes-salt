# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
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

trivalent-subresource-filter:
  pkg.installed

psutils:
  pkg.installed

'{{ name }}':
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - names:
      - /etc/trivalent/policies/managed/policy.json:
        - source: salt://templates/uses-app-trivalent/files/policy.json

/etc/X11/Xresources:
  file.replace:
    - pattern: |-
        Xft.dpi: 96
    - repl: |-
        Xft.dpi: 192

{% endif %}
