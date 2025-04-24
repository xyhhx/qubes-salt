# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

{% set name = "common.pkgs.audio" %}

'{{ name }} - update':
  pkg.uptodate:
    - refresh: true

'{{ name }} - install':
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

