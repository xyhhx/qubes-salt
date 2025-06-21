{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set user = salt["pillar.get"]("opts:dom0_user", "user") -%}

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
      - '/etc/qubes/policy.d/user.d/35-peripherals.policy':
          - source: 'salt://dom0/files/35-peripherals.policy'
      - '/etc/qubes/policy.d/user.d/35-ssh.policy':
          - source: 'salt://dom0/files/35-ssh.policy'

'/home/{{ user }}/policies':
  file.symlink:
    - target: '/etc/qubes/policy.d/user.d'

{% endif %}
