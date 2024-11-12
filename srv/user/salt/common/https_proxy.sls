# -*- coding: utf-8 -*-
# vim: set ts=2 sw=2 sts=2 et :

---

https_proxy:
  environ.setenv:
    - name: https_proxy
    - value: '127.0.0.1:8082'
    - update_minion: True

