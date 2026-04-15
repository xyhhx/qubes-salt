'dnf-plugins-core':
  pkg.installed:
    - install_recommends: false
    - skip_suggestions: true


{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
