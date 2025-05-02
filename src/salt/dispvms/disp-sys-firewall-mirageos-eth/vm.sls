# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = 'disp-sys-firewall-mirageos-eth' %}
{% set template = 'dvm-firewall-mirageos' %}
{% set netvm = 'disp-sys-net-eth' %}

{% if grains.id == 'dom0' %}

'{{ netvm }}':
  qvm.exists

'{{ vm_name }}':
  qvm.vm:
    - present:
      - class: DisposableVM
      - template: '{{ template }}'
      - label: orange
      - flags:
        - net
    - prefs:
      - netvm: '{{ netvm }}'
      - memory: 32
      - maxmem: 32
      - vcpus: 1
      - provides-network: true
    - features:
      - enable:
        - qubes-firewall
        - no-default-kernelopts
    - require:
      - qvm: '{{ template }}'
      - qvm: '{{ netvm }}'

{% endif %}
