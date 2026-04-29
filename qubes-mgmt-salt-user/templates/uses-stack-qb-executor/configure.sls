{%- if grains.id != "dom0" -%}

"{{ slsdotpath }}:: install pkgs":
  pkg.installed:
    - pkgs:
      # minimal template deps
      - qubes-core-agent-networking
      - qubes-core-agent-passwordless-root
      # builder deps
      - createrepo_c
      - debootstrap
      - devscripts
      - dnf-plugins-core
      - dosfstools
      - dpkg-dev
      - git
      - hostname
      - mock
      - pbuilder
      - perl-Digest-MD5
      - perl-Digest-SHA
      - pykickstart
      - python3-debian
      - python3-pyyaml
      - python3-sh
      - reprepro
      - rpm-build
      - rpmdevtools
      - systemd-udev
      - which
    - refresh: true

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
