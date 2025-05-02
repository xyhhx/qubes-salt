# vim: set ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains.id != 'dom0' %}
{% set vm_name = 'provides-firewall-linux' %}
{% set name = "templates.provides-firewall-linux.configure" %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - iproute
      - qubes-core-agent-dom0-updates
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true

{% endif %}
