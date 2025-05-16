# vim: set ts=2 sw=2 sts=2 et sts :

---
{% set vm_name = "provides-docker" %}
{% set base_template = 'fedora-41-minimal' %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - clone:
      - source: '{{ base_template }}'
    - prefs:
      - label: gray
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41
    - features:
      - set:
        - menu-items: Alacritty.desktop
    - require:
      - qvm: '{{ base_template }}'

{% else %}

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
