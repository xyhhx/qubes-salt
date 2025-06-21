{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

'{{ slsdotpath ~ ".sequoia-pgp" }}':
  pkg.installed:
    - pkgs:
      - sequoia-chameleon-gnupg
      - sequoia-keyring-linter
      - sequoia-keystore-server
      - sequoia-policy-config
      - sequoia-sop
      - sequoia-sq
      - sequoia-sqv
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
