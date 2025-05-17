# vim: set ts=2 sw=2 sts=2 et :
---
{% set name = "dom0.base-templates" %}
{% if grains.id == 'dom0' %}

'{{ name }}':
  qvm.template_installed:
    - names:
      - debian-12-minimal
      - fedora-41-minimal
      - fedora-41-xfce
      - whonix-gateway-17:
        - fromrepo: qubes-templates-community-testing
      - whonix-workstation-17:
        - fromrepo: qubes-templates-community-testing

{% endif %}
