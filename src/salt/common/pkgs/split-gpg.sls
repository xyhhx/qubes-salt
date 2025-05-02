# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = "common.split-gpg.init" %}
{% if grains.id != 'dom0' %}


'{{ name }}':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split
      - split-gpg2
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true
  file.managed:
    - source: salt://common/pkgs/templates/gitconfig.j2
    - template: jinja
    - mode: '0640'
{% if grains.get('qubes:type')  == 'template' %}
    - name: /etc/skel/.gitconfig
    - user: root
    - group: root
{% else %}
    - name: /home/user/.gitconfig
    - user: 1000
    - group: 1000
{% endif %}
{% endif %}
