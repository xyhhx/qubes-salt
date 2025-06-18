{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

{%- if salt["grains.get"]("qubes:type") == "template" %}

qubes-ctap:
  pkg.installed:
    - skip_suggestions: true
    - install_recommends: false
    - require_in:
      - service: qubes-ctapproxy@sys-usb.service
      - service: qubes-ctapproxy@sys-onlykey.service

{% endif -%}

qubes-ctapproxy@sys-usb.service:
  service.disabled

qubes-ctapproxy@sys-onlykey.service:
  service.enabled

{% endif %}
