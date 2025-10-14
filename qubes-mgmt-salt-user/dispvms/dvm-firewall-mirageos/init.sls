{%- set vm_name = 'dvm-sys-firewall-mirageos' -%}
{%- set template_name = 'provides-firewall-mirageos' -%}

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
      - template-for-dispvms: true
    - features:
      - enable:
        - skip-update
        - service.qubes-firewall
        - no-default-kernelopts

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
