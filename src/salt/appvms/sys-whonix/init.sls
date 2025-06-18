{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:net:vpn:tor") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:os:whonix_gw") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
<<<<<<< HEAD
=======
      - label: yellow
    - prefs:
      - template: '{{ template }}'
>>>>>>> main
      - label: yellow
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
