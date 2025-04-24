# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

{% if grains['id'] == 'dom0' %}

'dom0 - /etc/qubes/policy.d/user.d/49-onlykey.policy':
  file.managed:
    - source: 'salt://appvms/sys-onlykey/files/49-onlykey.policy'
    - mode: '0640'
    - makedirs: true

{% else %}

/usr/local/bin/ok-proxy-ssh-agent:
  file.managed:
    - source: salt://appvms/sys-onlykey/files/ok-proxy-ssh-agent
    - user: user
    - group: user
    - mode: "0755"

{% endif %}
