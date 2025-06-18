{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

{%- load_yaml as prefsmap %}
template:
  name: "/etc/skel/.gitconfig"
  user: "root"
  group: "root"
default:
  # TODO: these should be handled better
  name: "/home/user/.gitconfig"
  user: "user"
  group: "user"
{% endload -%}

{%- set prefs = salt['match.filter_by'](
  prefsmap,
  minion_id=salt['pillar.get']('qubes:type'),
  default='default'
  )
-%}

'{{ slsdotpath ~ ".split-gpg" }}':
  pkg.installed:
    - pkgs:
      - qubes-gpg-split
      - split-gpg2
    - skip_suggestions: true
    - install_recommends: false
  file.managed:
    - name: "{{ prefs.name }}"
    - source: salt://common/pkgs/templates/gitconfig.j2
    - template: jinja
    - mode: '0640'
    - context:
        gpg_user: '{{ salt["pillar.get"]("opts:gpg:user") }}'
        gpg_email: '{{ salt["pillar.get"]("opts:gpg:email") }}'
        gpg_pubkey: '{{ salt["pillar.get"]("opts:gpg:pubkey") }}'
    - user: "{{ prefs.user }}"
    - group: "{{ prefs.group }}"

{% endif %}
