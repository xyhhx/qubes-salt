# vim: set ts=2 sw=2 sts=2 et :
---

{% set name = "common.install-kicksecure" %}
{% if grains.os_family|lower == 'debian' %}

include:
  - common.https_proxy

'{{ name }} - preamble':
  pkg.installed:
    - pkgs:
      - adduser
      - extrepo
    - skip_suggestions: true
    - install_recommends: false
  group.present:
    - name: console
    - system: true
    - members:
      - user
  cmd.run:
    - name: 'extrepo enable kicksecure'
    - use_vt: true

'{{ name }} - install':
  pkg.installed:
    - pkgs:
      - kicksecure-qubes-cli
    - skip_suggestions: true
    - install_recommends: false
  cmd.run:
    - names:
      - 'repository-dist --enable --repository stable --transport onion'
      - 'extrepo disable kicksecure'
    - use_vt: true
  file.managed:
    - name: '/etc/apt/sources.list'
    - contents: ''
    - contents_newline: False

{% endif %}
