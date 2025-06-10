{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---

{# TODO: Configure debian docker hosts #}

{% set name = "common.pkgs.docker" %}
{% if grains.id != 'dom0' %}

{% if grains.os_family|lower == 'debian' %}
{% elif grains.os_family|lower == 'redhat' %}

docker-ce-stable:
  pkgrepo.managed:
    - hummanname: Docker CE Stable - $basearch
    - baseurl: https://download.docker.com/linux/fedora/$releasever/$basearch/stable
    - gpgcheck: true
    - gpgkey: https://download.docker.com/linux/fedora/gpg

'{{ name }}':
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-buildx-plugin
      - docker-compose-plugin
    - require:
      - pkgrepo: docker-ce-stable
  user.present:
    - names:
      - user
    - groups:
      - docker
    - remove_groups: false

{% endif %}
{% endif %}
