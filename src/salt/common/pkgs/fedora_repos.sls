{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' and grains.os_family | lower == 'redhat' %}

qubes-vm-r4.2-current-testing:
  pkgrepo.managed:
    - humanname: Qubes OS Repository for VM (updates-testing)
    - baseurl: https://yum.qubes-os.org/r4.2/current-testing/vm/fc$releasever
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-qubes-4.2-primary
    - skip_if_unavailable: false
    - enabled: true
    - gpgcheck: true
    - repo_gpgcheck: true
    - comments:
        - baseurl = http://yum.qubesosfasa4zl44o4tws22di6kepyzfeqv3tg4e3ztknltfxqrymdad.onion/r4.2/current-testing/vm/fc$releasever

{% endif %}
