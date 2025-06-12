{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
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
  default='else'
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
    - context:
        gpg_user: '{{ salt["pillar.get"]("opts:gpg:user") }}'
        gpg_email: '{{ salt["pillar.get"]("opts:gpg:email") }}'
        gpg_pubkey: '{{ salt["pillar.get"]("opts:gpg:pubkey") }}'
{% for pref in prefs %}
    - {{ pref }}: {{ prefs[pref] }}
{% endfor %}

{% endif %}
{% endif %}
