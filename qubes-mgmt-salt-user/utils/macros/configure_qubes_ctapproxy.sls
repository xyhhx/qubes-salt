{%- set default_usb_qube = salt["pillar.get"]("user_qubes:defaults:usb", default="sys-usb") -%}
{%- set default_ctap_qube = salt["pillar.get"]("user_qubes:defaults:ctap", default=default_usb_qube) -%}

{%- macro configure_qubes_ctapproxy(ctap_qube=default_ctap_qube) -%}
{%- if grains.id != "dom0" and salt["pillar.get"]("qubes:type") == "template" -%}

"{{ slsdotpath }}:: disable default ctap proxy":
   service.disabled:
    - name: "qubes-ctapproxy@sys-usb.service"

"{{ slsdotpath }}:: enable ctap proxy on preferred qvm":
  service.enabled:
    - require:
      - service: "{{ slsdotpath }}:: disable default ctap proxy"
    - name: "qubes-ctapproxy@{{ ctap_qube }}.service"

{%- endif -%}
{%- endmacro -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
