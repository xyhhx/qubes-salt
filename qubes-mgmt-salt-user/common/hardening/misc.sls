'{{ slsdotpath }}: {{ sls }}':
  file.managed:
    - names:
{% for file in [
      'etc/security/limits.d/30-disable-coredump.conf',
      'etc/systemd/coredump.conf.d/disable.conf',
      'etc/environment.d/30-disable-jit'
] %}
      - '/{{ file }}':
        - source: 'salt://{{ tpldir }}/files/{{ file }}'
{% endfor %}
    - makedirs: true
    - user: 'root'
    - group: 'root'
    - mode: '0644'
    - dir_mode: '0755'

{#- vim: set syntax=salt.jinja.yaml.salt.jinja ts=2 sw=2 sts=2 et : -#}
