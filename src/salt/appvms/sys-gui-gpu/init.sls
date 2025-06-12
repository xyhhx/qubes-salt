{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}


{%- set name = "appvms.sys-gui-gpu.vm" -%}
{%- set vm_name = salt["pillar.get"]("vm_names:sysvms:gui") -%}
{%- set template = salt["pillar.get"]("vm_names:templates:providers:gui") -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - require:
      - qvm: '{{ template }}'
    - present:
      - template: '{{ template }}'
      - label: gray
    - prefs:
      - virt_mode: "hvm"
      - netvm: ""
      - guivm: ""
      - audiovm: ""
      - memory: 4000
      - maxmem: 0
      - vcpus: 4
      - kernelopts: "nopat iommu=soft swiotlb=8192 root=/dev/mapper/dmroot ro console=hvc0 xen_scrub_pages=0"
      - pcidevs:
        - '01:00.0'
    - features:
      - set:
        - gui-default-window-background-color: black
        - video-model: none
      - enable:
        - gui-allow-fullscreen
        - input-dom0-proxy
        - no-default-kernelopts
        - service.dummy-backlight
        - service.dummy-psu
        - service.guivm
        - service.lightdm
      - disable:
        - service.software-rendering
  file.managed:
    - names:
      - /etc/qubes/input-proxy-target:
        - contents: "TARGET_DOMAIN={{ vm_name }}"
        - user: root
        - group: root
        - mode: '0644'
      - /etc/qubes/policy.d/user.d/45-sys-gui-gpu.policy:
        - source: salt://appvms/sys-gui-gpu/templates/45-sys-gui-gpu.policy.j2
        - defaults:
            gui_vm: 'sys-gui-gpu'
            usb_vm: 'disp-sys-usb'
        - context:
            gui_vm: '{{ vm_name }}'
      - /etc/qubes/policy.d/user.d/50-gui-sys-gui-gpu.policy:
        - source: salt://appvms/sys-gui-gpu/templates/50-gui-sys-gui-gpu.policy.j2
        - defaults:
            vm_name: "sys-gui-gpu"
        - context:
            vm_name: '{{ vm_name }}'
    - template: jinja
    - user: 1000
    - group: 1000
    - mode: "0640"
    - makedirs: true

'{{ name }} - admin api policies':
  file.append:
    - names:
      - /etc/qubes/policy.d/include/admin-local-rwx:
        - text: |
            {{ vm_name }} @tag:guivm-{{ vm_name }} allow target=dom0
            {{ vm_name }} {{ vm_name }} allow target=dom0
      {# -  /etc/qubes/policy.d/include/admin-global-ro: #}
      - /etc/qubes/policy.d/include/admin-global-rwx:
        - text: |
            {{ vm_name }} @adminvm allow target=dom0
            {{ vm_name }} @tag:guivm-{{ vm_name }} allow target=dom0
            {{ vm_name }} {{ vm_name }} allow target=dom0

{% else %}

'{{ vm_name }}':
  file.managed:
    - names:
      - /home/user/.config/autostart/xscreensaver-autostart.desktop:
        - contents: |
            [Desktop Entry]
            OnlyShowIn=XFCE;
      - /home/user/.config/autostart/qvm-start-daemon.desktop:
        - contents: |
            [Desktop Entry]
            Name=Qubes Guid/Pacat
            Comment=Starts GUI/AUDIO daemon for Qubes VMs
            Icon=qubes
            Exec=qvm-start-daemon --all --watch
            Terminal=false
            Type=Application
      - /home/user/.config/autostart/nm-applet.desktop:
        - contents: |
            [Desktop Entry]
            Hidden=true
    - user: 1000
    - group: 1000
    - mode: '0640'
    - makedirs: True

/rw/config/rc.local:
  file.append:
    - text: |
        sudo usermod -p '{{ salt['pillar.get']('qvm:sys-gui-gpu-vm:password-hash', '!') }}' user

{% endif %}
