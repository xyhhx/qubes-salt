# vim: set ts=2 sw=2 sts=2 et :
#
# 1) Intial Setup: sync any modules, etc
# --> qubesctl saltutil.sync_all
#
# 2) Initial Key Import:
# --> qubesctl state.sls salt.gnupg
#
# 3) Highstate will execute all states
# --> qubesctl state.highstate
#
# 4) Highstate test mode only.  Note note all states seem to conform to test
#    mode and may apply state anyway.  Needs more testing to confirm or not!
# --> qubesctl state.highstate test=True

# === User Defined Salt States ================================================
user:
  '*':
    # Base OS templates
    - templates.on-debian-12-minimal
    - templates.on-kicksecure-17
    - templates.on-fedora-40-minimal
    - templates.on-fedora-40-xfce

    # Providers
    - templates.provides-audio
    - templates.provides-browsers-on-fedora
    - templates.provides-net
