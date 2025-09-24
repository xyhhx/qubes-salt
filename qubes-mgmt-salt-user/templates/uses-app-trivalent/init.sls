{%- set vm_name = "uses-app-trivalent" -%}
{%- set base_template = "fedora-42-minimal" -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template) }}

{% else %}

dnf-plugins-core:
  pkg.installed

'{{ sls }}:{{ vm_name }}':
  pkgrepo.managed:
    - names:
      - secureblue:
        - baseurl: https://repo.secureblue.dev
        - enabled: 1
        - gpgcheck: 1
        - repo_gpgcheck: 1
        - gpgkey: https://repo.secureblue.dev/secureblue.gpg
        - require_in:
          - pkg: trivalent
      - trivalent-copr:
        - copr: secureblue/trivalent
        - require:
          - pkg: dnf-plugins-core
        - require_in:
          - pkg: trivalent-subresource-filter
  pkg.installed:
    - pkgs:
      - trivalent
      - trivalent-subresource-filter

{% endif %}

{# vim: set ft=salt ts=2 sw=2 sts=2 et : #}
