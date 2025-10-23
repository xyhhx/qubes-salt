{%- if salt['grains.get']('os_family') | lower == 'redhat' -%}
{#-
  Set post quantum crypto policies
-#}
{#- select only pq or at least curve based crypto -#}
{%- set accepted_kex_alogs = [
  'mlkem768x25519-sha256',
  'sntrup761x25519-sha512',
  'sntrup761x25519-sha512@openssh.com',
  'curve25519-sha256',
  'curve25519-sha256@libssh.org',
] -%}

oqsprovider:
  pkg.installed

'update-crypto-libraries --set DEFAULT:TEST-PQ':
  cmd.run:
    - use_vt: true

'/etc/crypto-policies/back-ends':
  file.directory:
    - user: 'root'
    - group: 'root'
    - mode: '0755'
    - makedirs: true

'/etc/crypto-policies/back-ends/openssh.config':
  file.keyvalue:
    - key_values:
        KexAlgorithms: {{ accepted_kex_alogs | join(',') }}
    - separator: ' '
    - create_if_missing: true
    - uncomment: '#'

{%- endif -%}

'/etc/ssh/ssh_config.d/10-custom.conf':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/etc/ssh/ssh_config.d/10-custom.conf'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
