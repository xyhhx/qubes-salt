# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = "appvms.sys-audio.vm" %}
{% set vm_name = "sys-audio" %}

'{{ name }}':
  qvm.vm:
    - present:
      - template: provides-audio
      - label: yellow
      - netvm: none

/etc/qubes/policy.d/user.d/30-sys-audio.policy:
  file.managed:
    - source: salt://appvms/sys-audio/files/30-sys-audio.policy
    - user: 1000
    - group: 1000
    - mode: "0640"
    - makedirs: true
