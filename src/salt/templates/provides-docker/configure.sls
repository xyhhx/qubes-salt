# vim: set ts=2 sw=2 sts=2 et sts :

---
{% set vm_name = "provides-docker" %}

{% if grains.id != 'dom0' %}

/etc/qubes-bind-dirs.d/30_docker.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - makedirs: true
    - contents: |-
        binds+=( '/var/lib/docker/storage' )

/var/lib/docker/storage:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true

docker:
  service.enabled

{% endif %}
