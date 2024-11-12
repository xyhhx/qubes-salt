# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---

{% if grains['os_family']|lower == 'debian' %}

include:
  - common.https_proxy

'configure - update':
  pkg.uptodate:
    - refresh: true

'configure - install prerequisites':
  pkg.installed:
    - pkgs:
      - adduser
      - extrepo
    - skip_suggestions: true
    - install_recommends: false

'configure - add user to console group':
  group.present:
    - name: console
    - system: true
    - members:
      - user

'extrepo enable kicksecure':
  cmd.run

'configure - install kicksecure':
  pkg.installed:
    - pkgs:
      - kicksecure-qubes-cli
    - skip_suggestions: true
    - install_recommends: false

'repository-dist --enable --repository stable --transport onion':
  cmd.run

'extrepo disable kicksecure':
  cmd.run

/etc/apt/sources.list:
  file.managed:
    - contents: ''
    - contents_newline: False

{% endif %}