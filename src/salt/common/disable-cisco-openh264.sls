{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

{% if salt["pillar.get"]("qubes:type") == "template" and grains.os_family | lower == 'redhat' %}
include:
  - .pkgs.update

fedora-cisco-openh264:
  pkgrepo.managed:
    - enabled: 0
    - require_in:
      - pkg: "system update"
{% endif %}

{% endif %}
