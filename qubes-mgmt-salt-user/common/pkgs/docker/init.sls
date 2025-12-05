{%- if grains.id != 'dom0' -%}
{%- if salt['grains.get']('os_family') | lower == 'redhat' -%}
{%- from 'utils/user_info.jinja' import user -%}

{%- set docker_gpg_key = "https://download.docker.com/linux/fedora/gpg" -%}

'{{ slsdotpath }}':
  file.managed:
    - name: "/etc/docker/daemon.json"
    - source: "salt://{{ tpldir }}/files/daemon.json"
    - user: "root"
    - group: "root"
    - mode: "0644"
    - makedirs: true
  pkgrepo.managed:
    - name: "docker-ce"
    - baseurl: "https://download.docker.com/linux/fedora/$releasever/$basearch/stable"
    - gpgcheck: true
    - enabled: true
    - gpgkey: "{{ docker_gpg_key }}"
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-buildx-plugin
      - docker-compose-plugin
    - require:
      - pkgrepo: '{{ slsdotpath }}'
  service.running:
    - name: "docker"
    - enable: true
    - require:
      - pkg: '{{ slsdotpath }}'
  group.present:
    - name: "docker"
    - addusers:
      - "{{ user }}"
    - require:
      - service: '{{ slsdotpath }}'

{%- endif -%}
{%- endif -%}
{#- vim: set ft=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
