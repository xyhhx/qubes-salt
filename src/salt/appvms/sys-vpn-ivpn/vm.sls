# vim: set syntax=yaml ft=sls ts=2 sw=2 sts=2 et :
---
{% set vm_name = pillar.names.sysvms.vpn_ivpn %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: provides-ivpn
      - label: yellow
      - flags:
        - net
