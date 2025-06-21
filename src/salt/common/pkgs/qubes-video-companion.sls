{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

qubes-video-companion:
  pkg.installed

{% if grains.os_family | lower == "debian" %}
v4l2loopback-dkms:
  pkg.installed
{% endif %}

{% endif %}
