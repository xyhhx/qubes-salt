{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

---

{% set name = 'templates.uses-app-librewolf-f41.configure' %}
{% set vm_name = salt["pillar.get"]("vm_names:templates:uses:librewolf") %}
{% set base_template = 'fedora-41-minimal' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41
        - uses-app
    - features:
      - enable:
        - service.qubes-ctap-proxy
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

'{{ name }}':
  pkgrepo.managed:
    - name: librewolf
    - baseurl: https://repo.librewolf.net
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://repo.librewolf.net/pubkey.gpg
    - repo_gpgcheck: 1
    - require_in:
      - pkg: '{{ name }}'
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
        - source: salt://templates/uses-app-librewolf-f41/files/policies.json
      - /usr/lib/librewolf/managed-storage/uBlock0@raymondhill.net.json:
        - source: salt://templates/uses-app-librewolf-f41/files/uBlock0@raymondhill.net.json
      - /usr/lib/librewolf/managed-storage/jsr@javascriptrestrictor.json:
        - source: salt://templates/uses-app-librewolf-f41/files/jsr@javascriptrestrictor.json
      - /usr/lib/librewolf/managed-storage/{c607c8df-14a7-4f28-894f-29e8722976af}.json:
        - source: salt://templates/uses-app-librewolf-f41/files/{c607c8df-14a7-4f28-894f-29e8722976af}.json

qubes-ctapproxy@sys-usb.service:
  service.disabled

qubes-ctapproxy@sys-onlykey.service:
  service.running:
    - enable: true

{% endif %}
