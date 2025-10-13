{%- set vm_name = 'app-libreoffice' -%}
{%- set template_name = 'uses-app-libreoffice' -%}

{% if grains.id == 'dom0' %}

'{{ vm_name }}':
  qvm.vm:
    - present:
      - template: '{{ template_name }}'
      - label: 'blue'
    - prefs:
      - template: '{{ template_name }}'
      - label: 'blue'
      - memory: 2000
      - maxmem: 8000
      - vcpus: 2
    - features:
      - enable:
        - service.custom-persist
      - set:
        - custom-persist.home_config_libreoffice: 'dir:user:user:0700:/home/user/.config/libreoffice'
        - custom-persist.home_config_thunar: 'dir:user:user:0700:/home/user/.config/Thunar'
        - custom-persist.home_docs: 'dir:user:user:0700:/home/user/Documents'
        - custom-persist.home_templates: 'dir:user:user:0700:/home/user/Templates'
        - custom-persist.home_local_fonts: 'dir:user:user:0700:/home/user/.local/share/fonts'
        - menu-items: 'libreoffice-base.desktop libreoffice-calc.desktop libreoffice-draw.desktop libreoffice-impress.desktop libreoffice-math.desktop libreoffice-writer.desktop thunar.desktop'

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
