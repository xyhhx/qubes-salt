{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}


'tighten umask':
  service.masked:
    - names:
      - debug-shell.service
      - kdump.service
  file.keyvalue:
    - names:
      - /etc/login.prefs:
        - key: UMASK
        - value: 077
      - /etc/bashrc:
        - key: umask
        - value: 077

/etc/login.defs:
  file.comment:
    - regex: "^HOME_MODE"
    - ignore_missing: true

'hardened confs':
  file.managed:
    - names:
      - /etc/modprobe.d/workstation-blacklist.conf:
        - source: salt://common/hardening/files/blacklist.conf
      - /etc/sysctl.d/99-workstation.conf:
        - source: salt://common/hardening/files/99-workstation.conf
      - /etc/security/limits.d/30-disable-coredump.conf:
        - contents: |
            * hard core 0
      - /etc/systemd/coredump.conf.d/disable.conf:
        - contents: |
            [Coredump]
            Storage=none
      - /etc/environment.d/99-disable-jit:
        - contents: |
            JavaScriptCoreUseJIT=0
            GJS_DISABLE_JIT=1
{%- if grains.os_family | lower == "redhat" -%}
      - /etc/dnf/dnf.conf:
        - source: salt://common/hardening/files/dnf.conf
{%- endif -%}
    - user: root
    - group: root
    - mode: '0600'
    - makedirs: true
    - replace: true

/etc/yum.repos.d/*:
  file.replace:
    - pattern: '(^metalink=.*)'
    - repl: "\1\&protocol=https"

'sysctl -p':
  cmd.run:
    - use_vt: true

