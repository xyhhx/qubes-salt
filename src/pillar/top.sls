# vim: set ts=2 sw=2 sts=2 et :
#

# ===== User Defined Salt Pillars =============================================

{% import_yaml '/home/whomst/.config/qubes-mgmt-salt-user/config.yml' as config %}

user:
  '*':
    - names
