# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

{% set name = "common.pkgs.base" %}

'{{ name }} - update':
  pkg.uptodate:
    - refresh: true
    - order: first

'{{ name }} - install':
  pkg.installed:
    - pkgs:
      - curl
      - xclip
{% if grains['os_family']|lower == 'debian' %}
      - vim
{% elif grains['os_family']|lower == 'redhat' %}
      - vim-common
{% endif %}
    - skip_suggestions: true
    - install_recommends: false

