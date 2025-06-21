{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:templates:providers:docker", "provides-docker") -%}

{% if grains.id == 'dom0' %}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

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
