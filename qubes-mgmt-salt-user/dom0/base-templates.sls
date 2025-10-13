{%- if grains.id == 'dom0' -%}

{% load_yaml as base_templates %}
qubes-templates-itl:
  - fedora-42-minimal
qubes-templates-itl-testing:
  - debian-13
  - debian-13-minimal
  - debian-13-xfce
  - fedora-42-minimal
  - fedora-42-xfce
qubes-templates-community-testing:
  - archlinux
  - kicksecure-17
  - whonix-gateway-17
  - whonix-workstation-17
{% endload %}

'{{ slsdotpath }}: install qubes base templates':
  qvm.template_installed:
    - names:
{%- for template in base_templates['qubes-templates-itl'] %}
      - '{{ template }}'
{%- endfor %}

'{{ slsdotpath }}: install qubes testing templates':
  qvm.template_installed:
    - names:
{%- for template in base_templates['qubes-templates-itl-testing'] %}
      - '{{ template }}'
{%- endfor %}
    - fromrepo: 'qubes-templates-itl-testing'

'{{ slsdotpath }}: install qubes community testing templates':
  qvm.template_installed:
    - names:
{%- for template in base_templates['qubes-templates-community-testing'] %}
      - '{{ template }}'
{%- endfor %}
    - fromrepo: 'qubes-templates-community-testing'

{%- endif -%}

# vim: set syn=salt.jinja.yaml ts=2 sw=2 sts=2 et :

