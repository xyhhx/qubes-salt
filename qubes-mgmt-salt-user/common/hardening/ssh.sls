{%- if salt['grains.get']('os_family') | lower == 'redhat' -%}
{#-
  Set post quantum crypto policies
-#}

{%- set policy = "DEFAULT:TEST-PQ" -%}

{%- if salt['grains.get']('osrelease') | to_num < 43 -%}
{#- Fedora 43 ships with a version of OpenSSL that natively supports OQS -#}
oqsprovider:
  pkg.installed
{%- endif -%}

'update-crypto-policies --set {{ policy }}':
  cmd.run:
    - use_vt: true
    - onlyif:
      - "! test $(cat /etc/crypto-policies/state/current) = {{ policy }}"

'/etc/crypto-policies/back-ends':
  file.directory:
    - user: 'root'
    - group: 'root'
    - mode: '0755'
    - makedirs: true

'/etc/crypto-policies/back-ends/openssh.config':
  file.keyvalue:
    - key_values:
        KexAlgorithms: {{ [
  'mlkem768x25519-sha256',
  'sntrup761x25519-sha512',
  'sntrup761x25519-sha512@openssh.com',
  'curve25519-sha256',
  'curve25519-sha256@libssh.org',
] | join(',') }}
    - separator: ' '
    - create_if_missing: true
    - uncomment: '#'

{% endif %}

'/etc/ssh/ssh_config.d/10-custom.conf':
  file.managed:
    - source: 'salt://{{ tpldir }}/files/etc/ssh/ssh_config.d/10-custom.conf'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - makedirs: true

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
