{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - qubes-core-agent-passwordless-root
      - qubes-mgmt-salt-vm-connector
    - install_recommends: false
    - skip_suggestions: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
