{%- if grains.id == 'dom0' -%}

{#-
  Get rid of this annoying warning:

  /usr/lib/python3.14/site-packages/salt/template.py:74: DeprecationWarning: codecs.open() is deprecated. Use open() instead.
    with codecs.open(template, encoding=SLS_ENCODING) as ifile:
-#}

'/usr/lib/python3.13/site-packages/salt/template.py':
  file.replace:
    - pattern: 'codecs.open'
    - repl: 'open'
    - show_changes: true

{%- endif -%}

{#- vim: set syntax=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}
