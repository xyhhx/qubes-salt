# vim: set ts=2 sw=2 sts=2 et :
---
{% set vm_name = "app-simple-x" %}
{% set template = "provides-flatpak" %}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template }}'
      - label: blue
    - features:
      - set:
        - menu-items: >-
            chat.simplex.simplex.desktop
            com.github.tchx84.Flatseal.desktop
            Alacritty.desktop
    - require:
      - qvm: '{{ template }}'

'qvm-volume extend {{ vm_name }}:private 12Gi':
  cmd.run:
    - use_vt: true
    - onlyif:
      - 'qvm-ls {{ vm_name }}'
      - '[[ $(qvm-volume info {{ vm_name }}:private size | numfmt --to=iec-i) != 12Gi ]]'

{% else %}

'flatpak --user install chat.simplex.simplex -y --noninteractive':
  cmd.run:
    - runas: user
    - use_vt: true

{% endif %}
