{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}
---
{% if grains.id == 'dom0' %}

{% set name = "templates.provides-firewall-mirageos.kernel" %}
{% set vm_name = salt["pillar.get"]("vm_names:templates:providers:firewall_mirageos") %}

{% set version = salt["pillar.get"]("config:versions:mirageos", "latest") %}
{% set kernel = "qubes-firewall.xen" %}
{% set checksum = "qubes-firewall-release.sha256" %}
{% set download_base = "https://github.com/mirage/qubes-mirage-firewall/releases/download/" ~ version ~ "/" %}
{% set mirage_install_dir = "/var/lib/qubes/vm-kernels/mirage-firewall-" ~ version %}


# TODO: rewrite this in pure salt functions
'{{ name }} - download kernel':
  cmd.script:
    - source: 'salt://templates/provides-firewall-mirageos/download-kernel.sh'
    - env:
      - VERSION: '{{ version }}'
      - KERNEL_URL: '{{ download_base ~ kernel }}'
      - DIGEST_URL: '{{ download_base ~ checksum }}'
      - FORCE_OVERWRITE: 'yes'
    - creates: '{{ mirage_install_dir }}/vmlinuz'
    - cwd: /tmp
    - shell: /bin/bash
    - use_vt: true

{% endif %}
