# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = "common.pkgs.split-gpg" %}
{% if grains.id != 'dom0' %}

{%- set prefs = salt['match.filter_by']({
    'template': {
      'name': '/etc/skel/.gitconfig',
      'user': 'root'
      'group': 'root'
    },
    'else': {
      'name': '/home/user/.gitconfig',
      'user': 'user',
      'group': 'user'
    }
  },
  minion_id=salt['pillar.get']('qubes:type'),
  default='default'
  )
-%}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split
      - split-gpg2
    - skip_suggestions: true
    - install_recommends: false
  file.managed:
    - source: salt://common/pkgs/templates/gitconfig.j2
    - template: jinja
    - mode: '0640'
{{ prefs | dict_to_sls_yaml_params | indent }}
{% endif %}
{% endif %}
