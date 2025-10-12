{#-
Stolen shamelessly from
https://github.com/secureblue/secureblue/blob/124d6f2cf8f5b097502ea2b3d7edac7ab905da61/files/system/etc/modprobe.d/blacklist.conf
-#}
{%- load_yaml as mods -%}
- 9p
- adfs
- af_802154
- affs
- afs
- appletalk
- ath_pci
- atm
- ax25
- befs
- bluetooth
- btusb
- can
- cdrom
- ceph
- cifs
- coda
- cramfs
- dccp
- decnet
- dv1394
- econet
- ecryptfs
- firewire-core
- firewire-net
- firewire-ohci
- firewire-sbp2
- firewire_core
- firewire_ohci
- firewire_sbp2
- freevxfs
- gfs2
- gnss
- gnss-mtk
- gnss-serial
- gnss-sirf
- gnss-ubx
- gnss-usb
- hfs
- hfsplus
- ipx
- jffs2
- jfs
- joydev
- kafs
- ksmbd
- minix
- n-hdlc
- netrom
- nfs
- nfsv3
- nfsv4
- nilfs2
- ocfs2
- ohci1394
- orangefs
- p8022
- p8023
- pmt_class
- pmt_crashlog
- pmt_telemetry
- psnap
- raw1394
- rds
- reiserfs
- romfs
- rose
- sbp2
- sctp
- squashfs
- sr_mod
- sysv
- thunderbolt
- tipc
- ubifs
- udf
- ufs
- video1394
- vivid
- x25
- zonefs
{%- endload -%}

'/etc/modprobe.d/99-disallowed.conf':
  file.managed:
    - file: 'salt://{{ tpldir }}/files/etc/modprobe.d/99-disallowed.conf.j2'
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - replace: true
    - makedirs: true

{#- vim: set syntax=yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
