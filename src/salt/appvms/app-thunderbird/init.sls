{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:appvms:thunderbird", "app-thunderbird") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:uses:thunderbird", "uses-app-thunderbird") -%}
{% if grains.id == 'dom0' %}

include:
  - templates.{{ template }}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: blue
    - prefs:
      - template: '{{ template }}'
      - label: blue
    - features:
      - enable:
        - service.split-gpg2-client
      - set:
        - menu-items: net.thunderbird.Thunderbird.desktop
        - menu-favorites: "net.thunderbird.Thunderbird"
    - tags:
      - add:
        - split-gpg2-client
    - require:
      - sls: 'templates.{{ template }}'

{% else %}

/rw/config/rc.local.d/49-split-gpg2.rc:
  file.managed:
    - contents: |
        export SPLIT_GPG2_SERVER_DOMAIN="{{ salt["pillar.get"]("user_config:defaults:gpg2-server", "vault-pgp") }}"
    - makedirs: true
    - user: root
    - group: root
    - mode: '0755'

{% endif %}
