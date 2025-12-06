{%- set vm_name = "provides-mgmt" -%}
{%- set base_template = "fedora-43-minimal" -%}

{% if grains.id == 'dom0' %}
{%- load_yaml as options -%}
prefs:
  - audiovm: ""
  - management_dispvm: "dvm-fedora-43-xfce"
{%- endload -%}
{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{% else %}

'{{ vm_name }}':
  pkg.installed:
    - pkgs:
      - qubes-core-agent-passwordless-root
      - qubes-mgmt-salt-vm-connector
    - install_recommends: false
    - skip_suggestions: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
