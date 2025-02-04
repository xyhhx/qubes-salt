
# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

'/etc/qubes/policy.d/10-user.policy':
  file.managed:
    - contents: '!include-dir user.d/'
    - mode: '0640'
    - makedirs: true

'/etc/qubes/policy.d/user.d/10-custom.policy':
  file.managed:
    - source: 'salt://dom0/files/10-custom.policy'
    - mode: '0640'
    - makedirs: true

'/etc/qubes/policy.d/user.d/30-sys-audio.policy':
  file.managed:
    - source: 'salt://dom0/files/30-sys-audio.policy'
    - mode: '0640'
    - makedirs: true

'/etc/qubes/policy.d/user.d/30-sys-gui.policy':
  file.managed:
    - source: 'salt://dom0/files/30-sys-gui.policy'
    - mode: '0640'
    - makedirs: true

'/etc/qubes/policy.d/user.d/35-gpg.policy':
  file.managed:
    - source: 'salt://dom0/files/35-gpg.policy'
    - mode: '0640'
    - makedirs: true

'/etc/qubes/policy.d/user.d/35-peripherals.policy':
  file.managed:
    - source: 'salt://dom0/files/35-peripherals.policy'
    - mode: '0640'
    - makedirs: true

'/etc/qubes/policy.d/user.d/35-ssh.policy':
  file.managed:
    - source: 'salt://dom0/files/35-ssh.policy'
    - mode: '0640'
    - makedirs: true

'/home/{{ user }}/policies':
  symlink:
    - target: '/etc/qubes/policy.d/user.d'
