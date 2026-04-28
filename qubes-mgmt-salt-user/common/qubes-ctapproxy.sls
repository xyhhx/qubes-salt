{%- if salt["pillar.get"]("qubes:type") == "template" -%}

"{{ slsdotpath }}:: installed qubes-ctap":
  pkg.installed:
    - pkgs:
      - qubes-ctap
    - refresh: true
    - install_recommends: false
    - skip_suggestions: true

{%- else -%}

{%- from "utils/macros/configure_qubes_ctapproxy.sls" import configure_qubes_ctapproxy -%}

{{ configure_qubes_ctapproxy() }}

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
