{%- if grains.id != "dom0" -%}

{%- set signing_key = "/usr/share/keyrings/element-io-archive-keyring.gpg" -%}

include:
  - common.hardening.kicksecure

"{{ slsdotpath }}:: install pkgrepo":
  pkgrepo.managed:
    - require:
      - sls: common.hardening.kicksecure
    - name: "deb [signed-by={{ signing_key }}] https://packages.element.io/debian/ default main"
    - file: "/etc/apt/sources.list.d/element-io.list"
    - key_url: "salt://{{ tpldir | path_join( "files/vm", signing_key ) }}"

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - require:
      - pkgrepo: "{{ slsdotpath }}:: install pkgrepo"
    - pkgs:
      - element-desktop
      - element-nightly
      - gnome-keyring
      - qubes-core-agent-networking

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
