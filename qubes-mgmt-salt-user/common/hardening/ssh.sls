'/etc/crypto-policies/back-ends':
  file.directory:
    - user: 'root'
    - group: 'root'
    - mode: '0755'
    - makedirs: true

'/etc/crypto-policies/back-ends/openssh.config':
  file.keyvalue:
    - key_values:
        KexAlgorithms: 'sntrup761x25519-sha512@openssh.com,curve25519-sha256'
    - separator: ' '
    - create_if_missing: true
    - uncomment: '#'

'/etc/ssh/ssh_config.d/10-custom.conf':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/etc/ssh/ssh_config.d/10-custom.conf'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
