# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
provides-fedora-ivpn_appvm:
  qvm.exists:
    - name: {{ pillar['names']['appvms']['ivpn_fedora'] }}
    - template: {{ pillar['names']['templates']['provides_ivpn_fedora'] }}
    - flags:
      - net
ivpn dns -on:
  cmd.run
ivpn firewall -on:
  cmd.run
ivpn firewall -lan_allow:
  cmd.run
