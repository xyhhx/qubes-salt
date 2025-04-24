# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---

{% set name = "common.pkgs.docker" %}

{% if grains.os_family|lower == 'debian' %}
{% elif grains.os_family|lower == 'redhat' %}

'{{ name }} - pkgrepo.managed':
  pkgrepo.managed:
    - name: docker-ce-stable
    - hummanname: Docker CE Stable - $basearch
    - baseurl: https://download.docker.com/linux/fedora/$releasever/$basearch/stable
    - gpgcheck: true
    - gpgkey: https://download.docker.com/linux/fedora/gpg


'{{ name }} - pkg.installed':
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-buildx-plugin
      - docker-compose-plugin
    - skip_suggestions: true
    - install_recommends: false

{% endif %}
