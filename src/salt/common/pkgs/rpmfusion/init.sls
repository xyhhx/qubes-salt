{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- if grains.id != 'dom0' -%}
{%- if grains.os_family | lower == 'redhat' -%}

{%- set osrelease = salt["grains.get"]("osrelease", "41") -%}

/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-2020:
  file.managed:
    - source: salt://common/pkgs/rpmfusion/files/RPM-GPG-KEY-rpmfusion-nonfree-fedora-2020
    - user: root
    - group: root
    - mode: '0644'

'{{ slsdotpath }}.rpmfusion':
  file.symlink:
    - names:
      - /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-2020
      - /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-{{ osrelease }}
      - /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-{{ osrelease }}
    - target: /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-2020
  pkgrepo.managed:
    - names:
      - 'rpmfusion-free':
        - name: 'RPM Fusion for Fedora {{ osrelease }} - Free'
        - baseurl: 'http://download1.rpmfusion.org/free/fedora/releases/{{ osrelease }}/Everything/$basearch/os/'
        - metalink: 'https://mirrors.rpmfusion.org/metalink?repo=free-fedora-{{ osrelease }}&arch=$basearch'
        - gpgkey: 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-{{ osrelease }}'
      - 'rpmfusion-free-updates':
        - name: 'RPM Fusion for Fedora {{ osrelease }} - Free - Updates'
        - baseurl: 'http://download1.rpmfusion.org/free/fedora/updates/{{ osrelease }}/$basearch/'
        - metalink: 'https://mirrors.rpmfusion.org/metalink?repo=free-fedora-updates-released-{{ osrelease }}&arch=$basearch'
        - gpgkey: 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-{{ osrelease }}'
      - 'rpmfusion-nonfree':
        - name: 'RPM Fusion for Fedora {{ osrelease }} - Nonfree'
        - baseurl: 'http://download1.rpmfusion.org/nonfree/fedora/releases/{{ osrelease }}/Everything/$basearch/os/'
        - metalink: 'https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-{{ osrelease }}&arch=$basearch'
        - gpgkey: 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-{{ osrelease }}'
      - 'rpmfusion-nonfree-updates':
        - name: 'RPM Fusion for Fedora {{ osrelease }} - Nonfree - Updates'
        - baseurl: 'http://download1.rpmfusion.org/nonfree/fedora/updates/{{ osrelease }}/$basearch/'
        - metalink: 'https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-updates-released-{{ osrelease }}&arch=$basearch'
        - gpgkey: 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-{{ osrelease }}'
    - enabled: 1
    - enabled_metadata: 1
    - metadata_expire: '14d'
    - gpgcheck: 1
    - repo_gpgcheck: 0
    - type: 'rpm-md'

{%- endif -%}
{%- endif -%}
