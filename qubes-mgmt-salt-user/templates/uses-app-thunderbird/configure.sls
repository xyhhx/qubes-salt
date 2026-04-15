{%- if grains.id != "dom0" -%}

{%- set overrides_filepath = "/etc/thunderbird/defaults/pref/dove-overrides.js" -%}
{%- set env_conf_filepath = "/etc/environment.d/30-qubes-gpg-domain-default.conf" -%}

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
    - name: "{{ overrides_filepath }}"
    - source: "salt://{{ tpldir | path_join("files/vm", overrides_filepath ) }}"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

"{{ slsdotpath }}:: install default QUBES_GPG_DOMAIN environment":
  file.managed:
    - require:
      - pkg:  "{{ slsdotpath }}:: install pkgs"
    - name: "{{ env_conf_filepath }}"
    - source: "salt://{{ tpldir | path_join("files/vm", env_conf_filepath ) }}"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
