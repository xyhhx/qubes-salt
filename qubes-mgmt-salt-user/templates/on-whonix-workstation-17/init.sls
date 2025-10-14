{%- set vm_name = "on-whonix-workstation-17" -%}
{%- set base_template = "whonix-workstation-17" -%}

{% if grains.id == 'dom0' %}

{%- load_yaml as options -%}
features:
  - disable:
    - selinux
  - set:
    - default-menu-items: {{ [

  'Alacritty.desktop'
  'anondist-torbrowser_update.desktop',
  'janondisttorbrowser.desktop',
  'systemcheck.desktop',
  'thunar.desktop',

] | join(' ' ) }}

{%- endload -%}

{% from "utils/macros/create_templatevm.sls" import templatevm %}
{{ templatevm(vm_name, base_template=base_template, options=options) }}

{% else %}

'{{ slsdotpath }}':
  file.managed:
    - names:
      - '/etc/sdwdate-gui.d/50_user.conf':
        - contents: |
            gateway=@default
      - '/etc/firefox-esr/50_prefs.js':
        - source: 'salt://{{ tpldir }}/files/etc/firefox-esr/50_prefs.js'
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - attrs: 'i'
    - makedirs: true

{% endif %}

# vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et :
