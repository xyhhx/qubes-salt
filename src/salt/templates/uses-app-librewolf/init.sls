{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:uses:librewolf", "uses-app-librewolf") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

'{{ vm_name }}':
  pkgrepo.managed:
    - name: librewolf
    - baseurl: https://repo.librewolf.net
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://repo.librewolf.net/pubkey.gpg
    - repo_gpgcheck: 1
    - require_in:
      - pkg: '{{ vm_name }}'
  pkg.installed:
    - names:
      - qubes-ctap
      - librewolf
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - names:
      - /etc/librewolf/policies/policies.json:
        - source: salt://templates/uses-app-librewolf/files/policies.json
      - /usr/lib/librewolf/managed-storage/uBlock0@raymondhill.net.json:
        - source: salt://templates/uses-app-librewolf/files/uBlock0@raymondhill.net.json
      - /usr/lib/librewolf/managed-storage/jsr@javascriptrestrictor.json:
        - source: salt://templates/uses-app-librewolf/files/jsr@javascriptrestrictor.json
      - /usr/lib/librewolf/managed-storage/{c607c8df-14a7-4f28-894f-29e8722976af}.json:
        - source: salt://templates/uses-app-librewolf/files/{c607c8df-14a7-4f28-894f-29e8722976af}.json

{% endif %}
