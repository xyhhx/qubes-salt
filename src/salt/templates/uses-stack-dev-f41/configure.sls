# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
---

# Avoid applying the state by mistake to dom0
{% if grains['nodename'] != 'dom0' %}

{% set vm_name = "uses-stack-dev-f41" %}
{% set name = "templates.uses-stack-dev-f41.configure" %}

'{{ name }} - pkg.installed':
  pkg.installed:
    - pkgs:
      - tmux
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
