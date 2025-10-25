{%- set vm_name = "uses-app-trivalent" -%}
{%- set base_template = "fedora-42-minimal" -%}

{%- if grains.id == 'dom0' -%}

{%- from "utils/macros/create_templatevm.sls" import templatevm -%}
{{ templatevm(vm_name, base_template=base_template) }}

{%- else -%}

include:
  - common.pkgs.dnf-plugins-core

'{{ slsdotpath }}':
  pkgrepo.managed:
    - names:
      - secureblue:
        - baseurl: 'https://repo.secureblue.dev'
        - enabled: 1
        - gpgcheck: 1
        - repo_gpgcheck: 1
        - gpgkey: 'https://repo.secureblue.dev/secureblue.gpg'
        - require_in:
          - pkg: 'trivalent'
      - trivalent-copr:
        - copr: 'secureblue/trivalent'
        - require:
          - pkg: 'dnf-plugins-core'
        - require_in:
          - pkg: 'trivalent-subresource-filter'
  pkg.installed:
    - pkgs:
      - qubes-core-agent-networking
      - trivalent
      - trivalent-subresource-filter

{% include tpldir ~ '/titanium.sls' %}

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
