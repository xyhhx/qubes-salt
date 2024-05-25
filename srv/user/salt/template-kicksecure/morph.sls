template-kicksecure_update:
  pkg.uptodate:
    - refresh: true

template-kicksecure_preinstall:
  pkg.installed:
    - pkgs:
      - sudo
      - adduser
      - extrepo
    - skip_suggestions: true
    - install_recommends: false 

template-kicksecure_console-group:
  group.present:
    - name: console
    - system: true
    - members:
      - user

template-kicksecure_user-group:
  group.present:
    - name: sudo
    - addusers:
      - user 

'sudo http_proxy=http://127.0.0.1:8082 https_proxy=http://127.0.0.1:8082 extrepo enable kicksecure':
  cmd.run

template-kicksecure_install-kicksecure:
  pkg.installed:
    - pkgs:
      - kicksecure-qubes-cli

'sudo repository-dist --enable --repository stable --transport onion':
  cmd.run

'sudo exrepo disable kicksecure':
  cmd.run

template-kicksecure_empty-sources-list:
  file.managed:
    - name: /etc/apt/sources.list
    - source:
      - sources.list
