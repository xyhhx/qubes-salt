# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

include:
  - common.https_proxy

trivalent:
  pkgrepo.managed:
    - copr: secureblue/trivalent
  pkg.installed:
    - trivalent

{% endif %}
