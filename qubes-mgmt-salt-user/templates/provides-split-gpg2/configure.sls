{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      - pinentry-qt
      - sequoia-chameleon-gnupg
      - sequoia-keystore-server
      - sequoia-policy-config
      - sequoia-sop
      - sequoia-sq
      - sequoia-sqv
      - split-gpg2
    - install_recommends: false
    - skip_suggestions: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
