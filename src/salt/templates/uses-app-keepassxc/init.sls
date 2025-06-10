{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

---
{% set vm_name = salt["pillar.get"]("vm_names:templates:uses:-keepassxc") %}
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
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

qubes-usb-proxy:
  pkg.installed

keepassxc:
  pkg.installed

qrencode:
  pkg.installed

{% endif %}
