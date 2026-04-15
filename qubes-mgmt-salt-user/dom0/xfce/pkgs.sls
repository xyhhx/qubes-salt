{%- if grains.id == 'dom0' -%}

'{{ slsdotpath }}: install desired xfce pkgs':
  pkg.installed:
    - pkgs:
      - deepin-gtk-theme
      - deepin-icon-theme
      - liberation-sans-fonts
      - xfce4-whiskermenu-plugin

{%- endif -%}
{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
