{%- if grains.id == 'dom0' -%}

{% load_yaml as base_templates %}
qubes-templates-itl:
  - fedora-42-minimal
qubes-templates-itl-testing:
  - debian-12-minimal
  - debian-13
  - debian-13-minimal
  - debian-13-xfce
  - fedora-42-minimal
  - fedora-42-xfce
  - fedora-43
  - fedora-43-minimal
  - fedora-43-xfce
qubes-templates-community-testing:
  - archlinux
  - kicksecure-18
  - whonix-gateway-18
  - whonix-workstation-18
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

{%- set all_templates = [] -%}
{%- set all_templates = all_templates | union(base_templates['qubes-templates-itl']) -%}
{%- set all_templates = all_templates | union(base_templates['qubes-templates-itl-testing']) -%}
{%- set all_templates = all_templates | union(base_templates['qubes-templates-community-testing']) -%}

{% for template in all_templates %}
'{{ template }}':
  qvm.tags:
    - add:
      - base-template
{% endfor %}

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}

