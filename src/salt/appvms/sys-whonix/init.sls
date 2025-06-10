{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---
{% set name = "appvms.sys-whonix.init" %}
{% set vm_name = salt["pillar.get"]("vm_names:net:vpn:tor") %}
{% if grains.id == 'dom0' %}

'{{ name }}':
  qvm.vm:
    - present:
      - template: whonix-gateway-17
      - label: yellow
      - netvm: none
    - tags:
      - add:
        - anon-vm

/etc/qubes/policy.d/user.d/80-whonix.policy:
  file.managed:
    - source: salt://appvms/sys-whonix/files/80-whonix.policy
    - user: 1000
    - group: 1000
    - mode: "0640"
    - makedirs: true


{% endif %}
