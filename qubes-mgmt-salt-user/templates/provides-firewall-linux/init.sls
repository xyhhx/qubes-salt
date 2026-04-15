{%- set vm_name = "provides-firewall-linux" -%}
{%- set base_template = "fedora-43-minimal" -%}

{%- if grains.id == "dom0" -%}

{%- from "utils/macros/create_templatevm.sls" import templatevm -%}
{{ templatevm(vm_name, base_template=base_template) }}

{%- else -%}

"{{ vm_name }}":
  pkg.installed:
    - pkgs:
      - iproute
      - qubes-core-agent-dom0-updates
      - qubes-core-agent-networking
    - install_recommends: false
    - skip_suggestions: true

{%- endif -%}

{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
