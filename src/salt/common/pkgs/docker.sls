# vim: set ts=2 sw=2 sts=2 et :

---

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
    - skip_suggestions: true
    - install_recommends: false
    - aggregate: true
  user.present:
    - names:
      - user
    - groups:
      - docker
    - remove_groups: false

{% endif %}
{% endif %}
