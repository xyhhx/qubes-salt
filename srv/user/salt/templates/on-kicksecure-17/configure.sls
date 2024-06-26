# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'on-kicksecure-17.configure - update':
  pkg.uptodate:
    - refresh: true

'on-kicksecure-17.configure - install prerequisites':
  pkg.installed:
    - pkgs:
      - sudo
      - adduser
      - extrepo
    - skip_suggestions: true
    - install_recommends: false

'on-kicksecure-17.configure - add user to console group':
  group.present:
    - name: console
    - system: true
    - members:
      - user

'on-kicksecure-17.configure - add sudo group':
  group.present:
    - name: sudo
    - addusers:
      - user

'sudo http_proxy=http://127.0.0.1:8082 https_proxy=http://127.0.0.1:8082 extrepo enable kicksecure':
  cmd.run

'on-kicksecure-17.configure - install kicksecure':
  pkg.installed:
    - pkgs:
      - kicksecure-qubes-cli
    - skip_suggestions: true
    - install_recommends: false

flatpak:
  pkg.removed

'sudo repository-dist --enable --repository stable --transport onion':
  cmd.run

'sudo extrepo disable kicksecure':
  cmd.run

/etc/apt/sources.list:
  file.managed:
    - source: salt://templates/on-kicksecure-17/files/sources.list

/etc/apt/sources.list.d/qubes-r4.list:
  file.managed:
    - source: salt://templates/on-kicksecure-17/files/qubes-r4.list

/etc/apt/sources.list.d/debian.list:
  file.managed:
    - source: salt://templates/on-kicksecure-17/files/debian.list
