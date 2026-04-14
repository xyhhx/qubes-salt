{%- if grains.id == 'dom0' -%}

{% load_yaml as base_templates %}
qubes-templates-itl: []
qubes-templates-itl-testing:
  - debian-13-minimal
  - debian-13-xfce
  - fedora-43-minimal
  - fedora-43-xfce
qubes-templates-community-testing:
  - whonix-gateway-18
  - whonix-workstation-18
{% endload %}

{%- for repo in [
  'qubes-templates-itl',
  'qubes-templates-itl-testing',
  'qubes-templates-community-testing'
] -%}

{%- if base_templates[repo] | length %}

'{{ slsdotpath }}: install base templates from {{ repo }}':
  qvm.template_installed:
    - names:
{%- for template in base_templates[repo] %}
      - '{{ template }}'
{%- endfor %}
    - fromrepo: '{{ repo }}'

{% endif -%}

{%- endfor -%}

{#-
  Base templates should be kept pristine and never be used. Instead, clone them
  and use those clones to do anything
-#}

{%- set all_templates = [] -%}
{%- set all_templates = all_templates | union(base_templates['qubes-templates-itl']) -%}
{%- set all_templates = all_templates | union(base_templates['qubes-templates-itl-testing']) -%}
{%- set all_templates = all_templates | union(base_templates['qubes-templates-community-testing']) -%}

{% for template in all_templates %}
'{{ template }}':
  qvm.features:
    - set:
      - skip-update: true
      - prohibit-start: "This is a base template. Clone it to use"
{% endfor %}

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
