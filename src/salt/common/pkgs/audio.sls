# vim: set ts=2 sw=2 sts=2 et :

---

{% set name = "common.pkgs.audio" %}
{% if grains.id != 'dom0' %}

'{{ name }}':
  pkg.installed:
    - pkgs:
      - pipewire
      - pipewire-qubes
      - pipewire-pulseaudio
      - wireplumber
      - alsa-utils
    - skip_suggestions: true
    - install_recommends: false
    - order: 1
    - aggregate: true

{% endif %}
