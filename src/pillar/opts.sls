{# vim: set syn=salt ts=2 sw=2 sts=2 et : #}

opts:
  dom0_user: "{{ salt["group.info"]("qubes").get("members")[0] }}"

  versions:
    mirages: "v0.9.4"

{#
  gpg:
    user:
    email:
    pubkey:
#}

