# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = 'templates.uses-app-trivalent.configure' %}

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}

'{{ name }}':
  pkgrepo.managed:
    - names:
      - secureblue:
        - baseurl: https://repo.secureblue.dev
        - enabled: 1
        - gpgcheck: 1
        - repo_gpgcheck: 1
        - gpgkey: https://repo.secureblue.dev/secureblue.gpg
        - require_in:
          - pkg: trivalent
    - trivalent-copr:
      - copr: secureblue/trivalent
      - require_in:
        - pkg: trivalent-subresource-filter
  pkg.installed:
    - aggregate: true
    - pkgs:
      - psutils
      - qubes-ctap
      - trivalent
      - trivalent-subresource-filter
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - names:
      - /etc/trivalent/policies/qubes-mgmt-salt-user.json:
        - source: salt://templates/uses-app-trivalent/files/policy.json

qubes-ctapproxy@sys-usb.service:
  service.disabled

qubes-ctapproxy@sys-onlykey.service:
  service.running:
    - enable: true

{% endif %}
