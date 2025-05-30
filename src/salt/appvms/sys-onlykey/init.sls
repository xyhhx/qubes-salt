# vim: set ts=2 sw=2 sts=2 et :
---

{% set vm_name = "sys-onlykey" %}
{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: provides-onlykey
      - label: yellow
      - netvm: ""
      - require:
        - qvm: provides-onlykey
    - tags:
      - add:
        - sys-vm
        - onlykey-server
        - gpg-server

/etc/qubes/policy.d/user.d/49-onlykey.policy:
  file.managed:
    - source: salt://appvms/sys-onlykey/files/49-onlykey.policy
    - mode: "0640"
    - makedirs: true

{% else %}

{% endif %}
