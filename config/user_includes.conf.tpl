---

file_roots:
  base:
    - /srv/salt
  user:
    - /srv/user/salt
    - ${CONFIG_DIR}/salt

pillar_roots:
  base:
    - /srv/pillar
    - /srv/pillar/base
  user:
    - /srv/user/pillar
    - ${CONFIG_DIR}/salt/pillar

include:
  - minion.d/*
  - ${CONFIG_DIR}/salt

# vim: set syn=yaml :

