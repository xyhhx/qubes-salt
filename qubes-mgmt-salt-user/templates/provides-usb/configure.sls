{%- if grains.id == "dom0" -%}
{%- set vm_name = "provides-usb" -%}

include:
  - dom0.pkgs.qubes-ctap

{%- else -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - qubes-input-proxy-sender
      - qubes-usb-proxy
    - install_recommends: false
    - skip_suggestions: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
