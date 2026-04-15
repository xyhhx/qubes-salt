{%- if grains.id == "dom0" -%}
{%-   set vm_name = "sys-onlykey" -%}
{%-   set template_name = "provides-onlykey-agent" -%}

"{{ vm_name }}":
  qvm.vm:
    - present:
      - template: "{{ template_name }}"
      - label: yellow
    - prefs:
      - template: "{{ template_name }}"
      - label: yellow
      - memory: 600
      - maxmem: 1000
      - netvm: ""
    - features:
      - enable:
        - custom-persist
        - minimal-usbvm
        - servicevm
      - set:
        - menu-items: Alacritty.desktop
        - custom-persist.home_ok_config: "dir:user:user:0700:/home/user/.config/onlykey"
        - custom-persist.gnupghome: "dir:user:user:0700:/home/user/.gnupg"
    - tags:
      - add:
        - onlykey-gpg-server
        - onlykey-ssh-server

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
