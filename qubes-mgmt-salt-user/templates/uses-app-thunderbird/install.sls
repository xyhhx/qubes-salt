{%- if grains.id != "dom0" -%}

include:
  - common.pkgs.dnf-plugins-core

"{{ slsdotpath }}:: install celenity copr":
  pkgrepo.managed:
    - copr: "celenity/copr"
    - enabled: true
    - require:
      - sls: common.pkgs.dnf-plugins-core

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - require:
      - pkgrepo: "{{ slsdotpath }}:: install celenity copr"
    - pkgs:
      - dove
      - qubes-core-agent-networking
      - qubes-gpg-split
      - sequoia-chameleon-gnupg
      - sequoia-sq
      - thunderbird

"{{ slsdotpath }}:: install dove overrides":
  file.managed:
    - require:
      - pkg:  "{{ slsdotpath }}:: install pkgs"
    - name: "/etc/thunderbird/defaults/pref/dove-overrides.js"
    - source: "salt://{{ tpldir }}/files/dove-overrides.js"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

"{{ slsdotpath }}:: install default QUBES_GPG_DOMAIN environment":
  file.managed:
    - require:
      - pkg:  "{{ slsdotpath }}:: install pkgs"
    - name: "/etc/environment.d/30-qubes-gpg-domain-default.conf"
    - source: "salt://{{ tpldir }}/files/30-qubes-gpg-domain-default.conf"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
