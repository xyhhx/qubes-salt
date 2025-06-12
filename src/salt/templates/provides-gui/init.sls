{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}


{%- set name = "templates.provides-gui.init" -%}
{% if grains.id == 'dom0' %}

qubes-input-proxy-sender:
  pkg.installed

dummy-psu-sender:
  pkg.installed

'provides-gui':
  qvm.vm:
    - clone:
      - source: 'fedora-41-minimal'
    - prefs:
      - class: TemplateVM
      - label: gray
      - include-in-backups: false
    - tags:
      - add:
        - salt-managed
        - fedora
        - fedora-41

{% else %}

'{{ name }}':
  pkg.installed:
    - pkgs:

      # Qubes tools
      - dummy-backlight-vm
      - dummy-psu-module
      - dummy-psu-receiver
      - qubes-desktop-linux-manager
      - qubes-manager
      - qubes-usb-proxy
      - qubes-vm-guivm

      # Basic system packages
      - gvfs
      - nvidia-gpu-firmware
      - nvtop
      - polkit
      - upower
      - xdg-user-dirs-gtk

      # Display manager
      - lightdm
      - lightdm-gobject
      - lightdm-autologin-greeter
      - lightdm-gtk
      - lightdm-gtk-greeter-settings
      - lightdm-settings
      - xscreensaver-base

      # GTK engines
      - gtk-murrine-engine
      - gtk-xfce-engine
      - gtk2-engines

      # XFCE packages
      - libxfce4ui
      - libxfce4util
      - xfce-polkit
      - xfce4-about
      - xfce4-appfinder
      - xfce4-battery-plugin
      - xfce4-calculator-plugin
      - xfce4-clipman-plugin
      - xfce4-cpufreq-plugin
      - xfce4-cpugraph-plugin
      - xfce4-datetime-plugin
      - xfce4-dict
      - xfce4-dict-plugin
      - xfce4-diskperf-plugin
      - xfce4-docklike-plugin
      - xfce4-eyes-plugin
      - xfce4-fsguard-plugin
      - xfce4-genmon-plugin
      - xfce4-mailwatch-plugin
      - xfce4-mount-plugin
      - xfce4-mpc-plugin
      - xfce4-netload-plugin
      - xfce4-notes-plugin
      - xfce4-notifyd
      - xfce4-panel
      - xfce4-panel-profiles
      - xfce4-places-plugin
      - xfce4-power-manager
      - xfce4-pulseaudio-plugin
      - xfce4-screenshooter
      - xfce4-screenshooter-plugin
      - xfce4-sensors-plugin
      - xfce4-session
      - xfce4-settings
      - xfce4-settings-qubes
      - xfce4-smartbookmark-plugin
      - xfce4-statusnotifier-plugin
      - xfce4-systemload-plugin
      - xfce4-taskmanager
      - xfce4-terminal
      - xfce4-time-out-plugin
      - xfce4-timer-plugin
      - xfce4-verve-plugin
      - xfce4-wavelan-plugin
      - xfce4-whiskermenu-plugin
      - xfce4-xkb-plugin
      - xfconf
      - xfdesktop
      - xfwm4
      - xfwm4-themes

      # Qt packages
      - kf6-qqc2-desktop-style
      - libaccounts-qt6-devel
      - libportal-qt6
      - polkit-qt6-1
      - python3-pyqt6
      - python3-pyqt6-base
      - python3-qdarkstyle
      - python3-qt5
      - python3-qt5-base
      - python3-superqt
      - python3-superqt+pyqt6
      - qqc2-breeze-style
      - qt5-qtbase
      - qt5-qtbase-gui
      - qt5-qtconnectivity
      - qt5-qtdeclarative
      - qt5-qtlocation
      - qt5-qtmultimedia
      - qt5-qtstyleplugins
      - qt5-qtsvg
      - qt5-qttools
      - qt5-qtx11extras
      - qt5ct
      - qt6-qt5compat
      - qt6-qtbase
      - qt6-qtdeclarative
      - qt6-qtsvg
      - qt6-qttools
      - qt6-qttools-common
      - qt6ct

      # Themes
      - elementary-xfce-icon-theme
      - greybird-xfce4-notifyd-theme
      - flat-remix-gtk2-theme
      - flat-remix-gtk3-theme
      - flat-remix-gtk4-theme
      - flat-remix-icon-theme
      - materia-gtk-theme
      - material-design-dark

    - refresh: true
    - cache_valid_time: 300

  file.recurse:
    - names:
      - /etc/systemd/system/lightdm.service.d:
        - source: salt://templates/provides-gui/files/lightdm
      - /etc/environment.d:
        - source: salt://templates/provides-gui/files/environment.d
    - user: root
    - group: root
    - dir_mode: '0755'
    - file_mode: '0644'
    - clean: true
    - makedirs: true
    - replace: true
  cmd.run:
    - name: 'systemctl enable lightdm'
    - use_vt: true
  user.present:
    - name: root
    - password: '!!'

'{{ name }} - purge extraneous pkgs':
  pkg.purged:
    - pkgs:
      - asunder
      - atril
      - blueman
      - bluez
      - claws-mail
      - firefox
      - geany
      - gnumeric
      - gparted
      - keepassxc
      - parole
      - pidgin
      - pragha
      - qubes-core-agent-networking # this qube must not have network access
      - thunderbird
      - transmission
      - xfburn
    - normalize: true

{% if grains.os_family | lower == 'redhat' %}
'dnf autoremove -y':
  cmd.run:
    - use_vt: true
{% endif %}

{% endif %}
