# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'template-kicksecure.configure - update':
  pkg.uptodate:
    - refresh: true

'template-kicksecure.configure - install prerequisites':
  pkg.installed:
    - pkgs:
      - sudo
      - adduser
      - extrepo
    - skip_suggestions: true
    - install_recommends: false

'template-kicksecure.configure - add user to console group':
  group.present:
    - name: console
    - system: true
    - members:
      - user

'template-kicksecure.configure - add sudo group':
  group.present:
    - name: sudo
    - addusers:
      - user

'sudo http_proxy=http://127.0.0.1:8082 https_proxy=http://127.0.0.1:8082 extrepo enable kicksecure':
  cmd.run

'template-kicksecure.configure - install kicksecure':
  pkg.installed:
    - pkgs:
      - kicksecure-qubes-cli
    - skip_suggestions: true
    - install_recommends: false

'template-kicksecure.configure - remove flatpak':
  pkg.removed:
    - pkgs:
      - flatpak

'sudo repository-dist --enable --repository stable --transport onion':
  cmd.run

'sudo extrepo disable kicksecure':
  cmd.run

'template-kicksecure.configure - empty sources.list':
  file.managed:
    - name: /etc/apt/sources.list
    - source:
      - salt://template-kicksecure/files/sources.list

'template-kicksecure.configure - onionize qubes repos':
  file.managed:
    - name: /etc/apt/sources.list.d/qubes-r4.list
    - source:
      - salt://template-kicksecure/files/qubes-r4.list

'template-kicksecure.configure - onionize debian repos':
  file.managed:
    - name: /etc/apt/sources.list.d/debian.list
    - source:
      - salt://template-kicksecure/files/debian.list
