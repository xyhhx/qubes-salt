# vim: set ts=2 sw=2 sts=2 et :
---
{% import_yaml '/home/whomst/.config/qubes-mgmt-salt-user/config.yml' as config %}

{% set vm_name = "provides-firewall-mirageos" %}
{% set mgmt_qube = "disp-mgmt-mirageos-fw" %}

{% set version = config.versions.mirageos %}
{% set kernel = "qubes-firewall.xen" %}
{% set checksum = "qubes-firewall-release.sha256" %}
{% set download_base = "https://github.com/mirage/qubes-mirage-firewall/releases/" ~ version ~ "/download/" %}
{% set mirage_install_dir = "/var/lib/qubes/vm-kernels/mirage-firewall-" ~ version %}

{% if grains.id == 'dom0' %}

'create_{{ mgmt_qube }}':
  qvm.vm:
    - name: '{{ mgmt_qube }}'
    - present:
      - label: red
      - template: 'on-fedora-41-xfce'
    - prefs:
      - include-in-backups: false

# TODO: rewrite this in pure salt functions
'salt://templates/provides-firewall-mirageos/download-kernel.sh':
  cmd.script:
    - env:
      - VERSION: '{{ version }}'
      - DOMU: '{{ mgmt_qube }}'
      - KERNEL_URL: '{{ download_base ~ kernel }}'
      - DIGEST_URL: '{{ download_base ~ checksum }}'
    - creates: '{{ mirage_install_dir }}/vmlinuz'
    - requires:
      - qvm: 'create_{{ mgmt_qube }}'

'{{ mgmt_qube }}':
  qvm.absent

{% endif %}
