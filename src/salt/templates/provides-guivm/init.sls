{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{%- set vm_name = salt["pillar.get"]("vm_names:providers:guivm", "provides-guivm") -%}

{% if grains.id == 'dom0' %}

qubes-input-proxy-sender:
  pkg.installed

dummy-psu-sender:
  pkg.installed

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name) }}

{% else %}

include:
  - common.pkgs.rpmfusion
  - common.pkgs.nvidia

'{{ vm_name }}':
  pkg.installed:
    - pkgs:

      # Dummy modules
      - dummy-backlight-vm
      - dummy-psu-module
      - dummy-psu-receiver

      # Qubes tools
      - qubes-desktop-linux-manager
      - qubes-manager
      - qubes-usb-proxy
      - qubes-vm-guivm

      # Basic system packages
      - gvfs
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
      - slick-greeter
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
      - xfce4-calculator-plugin
      - xfce4-clipman-plugin
      - xfce4-datetime-plugin
      - xfce4-dict
      - xfce4-dict-plugin
      - xfce4-docklike-plugin
      - xfce4-genmon-plugin
      - xfce4-notes-plugin
      - xfce4-notifyd
      - xfce4-panel
      - xfce4-panel-profiles
      - xfce4-places-plugin
      - xfce4-power-manager
      - xfce4-pulseaudio-plugin
      - xfce4-screenshooter
      - xfce4-screenshooter-plugin
      - xfce4-session
      - xfce4-settings
      - xfce4-settings-qubes
      - xfce4-statusnotifier-plugin
      - xfce4-systemload-plugin
      - xfce4-taskmanager
      - xfce4-terminal
      - xfce4-time-out-plugin
      - xfce4-timer-plugin
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
        - source: salt://templates/provides-guivm/files/lightdm
      - /etc/environment.d:
        - source: salt://templates/provides-guivm/files/environment.d
    - user: root
    - group: root
    - dir_mode: '0755'
    - file_mode: '0644'
    - clean: true
    - makedirs: true
    - replace: true
  user.present:
    - name: root
    - password: '!!'

'systemctl enable lightdm':
  cmd.run:
    - use_vt: true

'{{ slsdotpath }}.pkg.purged':
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
    - onchanges_any:
      - pkg: '{{ vm_name }}'
      - pkg: '{{ slsdotpath }}.pkg.purged'
{% endif %}

{% endif %}
