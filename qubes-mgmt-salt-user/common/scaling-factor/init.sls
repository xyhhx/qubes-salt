{%- if grains.id == 'dom0' -%}

'{{ slsdotpath }}: configure dom0':
  file.managed:
    - names:
      - '/usr/local/etc/qubes-rpc/qubes.GetScalingFactor':
        - source: 'salt://{{ tpldir }}/files/qubes.GetScalingFactor'
        - mode: '0755'
      - '/usr/local/etc/qubes/policy.d/available/50-scaling-factor.policy':
        - source: 'salt://{{ tpldir }}/files/scaling-factor.policy.j2'
    - template: 'jinja'
    - user: 'root'
    - group: 'qubes'
    - mode: '0640'
    - makedirs: true
    - replace: true

'/usr/local/etc/qubes/policy.d/enabled/50-scaling-factor.policy':
  file.symlink:
    - target: '/usr/local/etc/qubes/policy.d/available/50-scaling-factor.policy'
    - makedirs: true
    - user: 'root'
    - group: 'qubes'
    - mode: '0777'

{%- else -%}

'{{ slsdotpath }}: configure guest':
  file.managed:
    - names:
      - '/usr/lib/qubes-user/set-scaling-factor':
        - source: 'salt://{{ tpldir }}/files/set-scaling-factor'
      - '/etc/systemd/system/sync-scaling-factor.service':
        - source: 'salt://{{ tpldir }}/files/sync-scaling-factor.service'
    - user: 'root'
    - group: 'root'
    - mode: '0755'
    - makedirs: true
    - template: 'jinja'

'sync-scaling-factor.service':
  service.enabled

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
