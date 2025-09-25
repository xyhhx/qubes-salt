{%- set vm_name = 'dvm-sys-firewall-linux' -%}
{%- set template_name = 'provides-firewall-linux' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: yellow
    - prefs:
      - template: '{{ template_name }}'
      - label: yellow
      - netvm: sys-net
      - provides-network: true
      - memory: 500
      - template-for-dispvms: true
    - require:
      - qvm: provides-firewall-linux
      - qvm: sys-net

{% endif %}

# vim: set syntax=yaml ts=2 sw=2 sts=2 et : 
