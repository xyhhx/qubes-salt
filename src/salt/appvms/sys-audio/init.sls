{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:sysvms:audio") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
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

{% endif %}
