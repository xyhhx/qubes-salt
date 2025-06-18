{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set name = "common.hardening.kicksecure" -%}

{% if salt['pillar.get']('qubes:type') == 'template' and grains.os_family | lower == 'debian' %}

{%- load_yaml as repo_dist %}
  channel: 'stable'
  transport: 'onion'
{% endload -%}

include:
  - common.https_proxy

'{{ name }} - pkgs.installed':
  pkg.installed:
    - pkgs:
      - adduser
      - extrepo
    - skip_suggestions: true
    - install_recommends: false

console:
  group.present:
    - system: true
    - members:
      - user

'extrepo enable kicksecure':
  cmd.run:
    - use_vt: true
    - onchanges:
      - pkg: extrepo

kicksecure-qubes-cli:
  pkg.installed:
    - skip_suggestions: true
    - install_recommends: false
    - onchanges:
      - cmd: 'extrepo enable kicksecure'

'repo-dist':
  cmd.run:
    - name: 'repository-dist --enable --repository {{ repo_dist.channel }} --transport {{ repo_dist.transport }}'
    - use_vt: true

'extrepo disable kicksecure':
  cmd.run:
    - use_vt: true

/etc/apt/sources.list:
  file.managed:
    - contents: ''
    - contents_newline: False
    - listen_in:
      - cmd: 'repo-dist'
    - require:
      - pkg: kicksecure-qubes-cli

{% endif %}
