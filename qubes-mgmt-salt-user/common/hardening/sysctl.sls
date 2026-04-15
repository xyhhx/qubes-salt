{#-
Stolen shamelessly from:
https://github.com/Metropolis-nexus/Common-Files/blob/c752e0b3a2a092e889e7108c5a8b98516fb7de9a/etc/sysctl.d/99-workstation.conf
-#}
{%- load_yaml as sysctls -%}
'dev.tty.ldisc_autoload': 0
'fs.binfmt_misc.status': 0
'fs.protected_regular': 2
'fs.protected_fifos': 2
'fs.protected_symlinks': 1
'fs.protected_hardlinks': 1
'kernel.core_pattern': '/bin/false'
'fs.suid_dumpable': 0
'kernel.dmesg_restrict': 1
'kernel.kptr_restrict': 2
'kernel.kexec_load_disabled': 1
'kernel.unprivileged_bpf_disabled': 1
'net.core.bpf_jit_harden': 2
'kernel.unprivileged_userns_clone': 1
'kernel.yama.ptrace_scope': 3
'kernel.randomize_va_space': 2
'kernel.perf_event_paranoid': 4
'kernel.io_uring_disabled': 2
'kernel.sysrq': 0
'net.ipv4.conf.*.send_redirects': 0
'net.ipv4.conf.*.accept_redirects': 0
'net.ipv6.conf.*.accept_redirects': 0
'net.ipv4.conf.*.accept_source_route': 0
'net.ipv6.conf.*.accept_source_route': 0
'net.ipv4.conf.*.rp_filter': 1
'net.ipv4.icmp_echo_ignore_all': 1
'net.ipv6.icmp.echo_ignore_all': 1
'net.ipv4.ip_forward': 1
'net.ipv6.conf.all.forwarding': 1
'net.ipv4.icmp_ignore_bogus_error_responses': 1
'net.ipv4.tcp_rfc1337': 1
'net.ipv4.tcp_syncookies': 1
'net.ipv4.tcp_timestamps': 1
'net.ipv4.tcp_sack': 0
'net.ipv4.tcp_dsack': 0
'vm.mmap_rnd_bits': 32
'vm.mmap_rnd_compat_bits': 16
'vm.mmap_min_addr': 65536
'vm.unprivileged_userfaultfd': 0
{%- endload -%}

'/etc/sysctl.d/99-custom-hardening.conf':
  file.keyvalue:
    - key_values: {{ sysctls }}
    - separator: ' = '
    - key_ignore_case: false
    - value_ignore_case: false
    - create_if_missing: true
    - append_if_not_found: true
    - show_changes: true
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
