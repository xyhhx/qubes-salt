{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if salt["pillar.get"]("qubes:type") == 'template' %}

debug-shell.service:
  service.masked

kdump.service:
  service.masked

/etc/login.prefs:
  file.keyvalue:
    - key: UMASK
    - value: '077'
    - separator: ' '
    - append_if_not_found: true
    - onlyif:
      - '[[ test -f /etc/login.prefs ]]'

/etc/bashrc:
  file.keyvalue:
    - key: umask
    - value: '077'
    - separator: ' '
    - append_if_not_found: true
    - onlyif:
      - '[[ test -f /etc/bashrc ]]'

/etc/login.defs:
  file.comment:
    - regex: "^HOME_MODE"
    - ignore_missing: true
    - onlyif:
      - '[[ test -f /etc/login.def ]]'

'{{ slsdotpath }} - hardened confs':
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
    - user: root
    - group: root
    - mode: '0600'
    - makedirs: true
    - replace: true

{% if grains.os_family | lower == "redhat" %}
/etc/dnf/dnf.conf:
  file.keyvalue:
    - key_values:
        gpgcheck: True
        installonly_limit: 3
        clean_requirements_on_remove: True
        best: False
        skip_if_unavailable: True
        max_parallel_downloads: 10
        deltarpm: False
        defaultyes: True
        install_weak_deps: False
        countme: False
    - separator: '='
    - append_if_not_found: true
{% endif %}

'sysctl -p':
  cmd.run:
    - use_vt: true
    - onchanges:
      - file: '/etc/sysctl.d/99-workstation.conf'

{% endif %}
