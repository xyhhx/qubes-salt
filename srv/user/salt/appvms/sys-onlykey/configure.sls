# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---


/usr/local/bin/ok-proxy-ssh-agent:
  file.managed:
    - source: salt://appvms/sys-onlykey/files/ok-proxy-ssh-agent
    - user: user
    - group: user
    - mode: 0755
