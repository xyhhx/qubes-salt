{%- if grains.id != "dom0" -%}
{%- from "./opts.jinja" import policies -%}

include:
  - common.pkgs.dnf-plugins-core

"{{ slsdotpath }}:: install repos":
  pkgrepo.managed:
    - require:
      - sls: common.pkgs.dnf-plugins-core
    - names:
      - secureblue:
        - baseurl: "https://repo.secureblue.dev"
        - enabled: 1
        - gpgcheck: 1
        - repo_gpgcheck: 1
        - gpgkey: "https://repo.secureblue.dev/secureblue.gpg"
      - trivalent-copr:
        - copr: "secureblue/trivalent"

"{{ slsdotpath }}:: install packages":
  pkg.installed:
    - require:
      - pkgrepo: "{{ slsdotpath }}:: install repos"
    - pkgs:
      - qubes-core-agent-networking
      - qubes-ctap
      - trivalent
      - trivalent-subresource-filter

"{{ slsdotpath }}: install celenity/titanium":
  file.managed:
    - require:
      - pkg: "{{ slsdotpath }}:: install packages"
    - names:
{% for source, target in policies %}
      - "{{ target }}":
        - source: "salt://vendor/celenity-titanium/{{ source }}"
{% endfor %}
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true

{%- endif -%}
{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
