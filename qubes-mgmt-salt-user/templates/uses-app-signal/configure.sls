{%- if grains.id != "dom0" -%}

{%- set signing_key = "/usr/share/keyrings/signal-desktop-keyring.gpg" -%}

include:
  - common.hardening.kicksecure

"{{ slsdotpath }}:: install pkgrepo":
  pkgrepo.managed:
    - require:
      - sls: common.hardening.kicksecure
    - name: "deb [signed-by={{ signing_key }}] tor+https://updates.signal.org/desktop/apt xenial main"
    - file: "/etc/apt/sources.list.d/signal-desktop.list"
    - key_url: "salt://{{ tpldir | path_join("files/vm", signing_key) }}"

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - require:
      - pkgrepo: "{{ slsdotpath }}:: install pkgrepo"
    - pkgs:
      - signal-desktop
      - qubes-core-agent-networking

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
