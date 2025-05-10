# vim: set ts=2 sw=2 sts=2 et :
---

{% set user = pillar.config.dom0_user %}

{% if grains.id == 'dom0' %}

'dom0 - policies':
  file.managed:
    - mode: '0640'
    - makedirs: true
    - names:
      - '/etc/qubes/policy.d/10-user.policy':
          - contents: '!include-dir user.d/'
      - '/etc/qubes/policy.d/user.d/10-custom.policy':
          - source: 'salt://dom0/files/10-custom.policy'
      - '/etc/qubes/policy.d/user.d/10-updates.policy':
          - source: 'salt://dom0/files/10-updates.policy'
      - '/etc/qubes/policy.d/user.d/30-sys-audio.policy':
          - source: 'salt://dom0/files/30-sys-audio.policy'
      - '/etc/qubes/policy.d/user.d/30-sys-gui.policy':
          - source: 'salt://dom0/files/30-sys-gui.policy'
      - '/etc/qubes/policy.d/user.d/35-gpg.policy':
          - source: 'salt://dom0/files/35-gpg.policy'
      - '/etc/qubes/policy.d/user.d/35-peripherals.policy':
          - source: 'salt://dom0/files/35-peripherals.policy'
      - '/etc/qubes/policy.d/user.d/35-ssh.policy':
          - source: 'salt://dom0/files/35-ssh.policy'

'/home/{{ user }}/policies':
  file.symlink:
    - target: '/etc/qubes/policy.d/user.d'

{% endif %}
