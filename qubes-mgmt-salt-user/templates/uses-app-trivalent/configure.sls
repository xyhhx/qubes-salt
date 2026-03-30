{%- if grains.id != "dom0" -%}

{%- from "./opts.jinja" import ctap_proxy_vm -%}

{%- if ctap_proxy_vm != "sys-usb" -%}

"{{ slsdotpath }}:: disable default ctap proxy":
   service.disabled:
    - name: 'qubes-ctapproxy@sys-usb.service'

"{{ slsdotpath }}:: enable ctap proxy on preferred qvm":
  service.enabled:
    - require:
      - service: "{{ slsdotpath }}:: disable default ctap proxy"
    - name: "qubes-ctapproxy@{{ ctap_proxy_vm }}.service"

{%- endif -%}
{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
