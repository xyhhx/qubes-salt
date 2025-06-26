{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

{% if grains.id != 'dom0' %}

'mount /tmp -o remount,size=12G':
  cmd.run

grubby-dummy:
  pkg.purged

'{{ slsdotpath }}.nvidia - pkg.installed':
  pkg.installed:
    - names:
      - akmod-nvidia
      - xorg-x11-drv-nvidia-cuda
  loop.until_no_eval:
    - name: cmd.run
    - expected: 'nvidia'
    - period: 20
    - timeout: 600
    - args:
      - modinfo -F name nvidia
    - require:
      - pkg: akmod-nvidia
      - pkg: xorg-x11-drv-nvidia-cuda

/usr/share/X11/xorg.conf.d/nvidia.conf:
  file.absent:
    - require:
      - loop: '{{ slsdotpath }}.nvidia - pkg.installed'

/etc/default/grub:
  file.append:
    - text: 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX rd.driver.blacklist=nouveau"'

'grub2-mkconfig -o /boot/grub2/grub.cfg':
  cmd.run:
    - use_vt: true
    - require:
      - file: '/etc/default/grub'

{% endif %}
