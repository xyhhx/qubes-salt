# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

{% set name = "common.install-kicksecure" %}
{% if grains.os_family|lower == 'debian' %}

include:
  - common.https_proxy

'{{ name }} - configure - install prerequisites':
  pkg.installed:
    - pkgs:
      - adduser
      - extrepo
    - skip_suggestions: true
    - install_recommends: false

'{{ name }} - configure - add user to console group':
  group.present:
    - name: console
    - system: true
    - members:
      - user

'extrepo enable kicksecure':
  cmd.run

'{{ name }} - configure - install kicksecure':
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
