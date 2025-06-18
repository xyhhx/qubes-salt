{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set name = "dom0.base-templates" -%}
{% if grains.id == 'dom0' %}

'{{ name }}':
  qvm.template_installed:
    - names:
      - debian-12-minimal
      - fedora-41-minimal
      - fedora-41-xfce
      - fedora-42-minimal:
        - fromrepo: qubes-templates-itl-testing
      - fedora-42-xfce:
        - fromrepo: qubes-templates-itl-testing
      - whonix-gateway-17:
        - fromrepo: qubes-templates-community-testing
      - whonix-workstation-17:
        - fromrepo: qubes-templates-community-testing
      - archlinux:
        - fromrepo: qubes-templates-community-testing

{% endif %}
