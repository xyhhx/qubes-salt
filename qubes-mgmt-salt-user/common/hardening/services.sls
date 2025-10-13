'{{ slsdotpath }}: {{ sls }}':
  service.masked:
    - names:
      - debug-shell
      - kdump

{#- vim: set syntax=yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
