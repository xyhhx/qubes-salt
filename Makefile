BUNDLE_FILE    ?= /tmp/salt.bundle
USER_SALT_DIR  ?= /srv/user
DEV_VM_WORKDIR ?= /home/user/qubes-salt

$$(BUNDLE_FILE):
	qvm-run -p $$(QUBES_DEV_DOMAIN) 'cd $$(DEV_VM_WORKDIR) && git bundle create - --all' > $$(BUNDLE_FILE)
