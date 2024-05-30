# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

---
'dvm-browsers.vm':
  qvm.vm:
    - name: {{ pillar.names.dispvms.browsers }}
    - present:
      - template: {{ pillar.names.templates.providers.flatpak }}
      - label: red
    - prefs:
      - template-for-dispvms: true

'qvm-volume extend {{ pillar.names.dispvms.browsers }}:private 12Gi':
  cmd.run

'dvm-browsers.vm - qvm.features':
  qvm.features:
   - name: {{ pillar.names.dispvms.browsers }}
   - set:
     - menu-items: "io.gitlab.librewolf-community.desktop io.github.ungoogled_software.ungoogled_chromium.desktop"
     - default-menu-items: "io.gitlab.librewolf-community.desktop io.github.ungoogled_software.ungoogled_chromium.desktop"

'qvm-sync-appmenus --regenerate-only --force-root {{ pillar.names.dispvms.browsers }}':
  cmd.run
