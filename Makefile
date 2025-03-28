BUNDLE_FILE    ?= /tmp/salt.bundle
CURRENT_DOMAIN  ?= $(shell qubesdb-read /name)
DEV_VM_WORKDIR ?= $(realpath .)
USER_SALT_DIR  ?= $(HOME)/salt
USER_SALT_SRV  ?= /srv/user

# ----------------------------------------------------------------------------
#  install commands

.PHONY: cmd-git-bundle
cmd-git-bundle:
	@echo \
		qvm-run -p $(CURRENT_DOMAIN) \
			"'cd $(DEV_VM_WORKDIR) && git bundle create - --all'" \
			\> $(BUNDLE_FILE)


.PHONY: cmd-minion-patch
cmd-minion-patch:
	@echo \
		qvm-run -p $(CURRENT_DOMAIN) \
		  "'cat $(DEV_VM_WORKDIR)/hack/f_defaults.conf.patch'" \
		  \| sudo patch /etc/salt/minion.d/f_defaults.conf


.PHONY: cmd-symlink-salts
cmd-symlink-salts:
	@echo ln -s $(USER_SALT_DIR) $(USER_SALT_SRV)

.PHONY:
cmd-install-domu: cmd-git-bundle cmd-minion-patch cmd-symlink-salts

.PHONY: cmd-install-dom0
cmd-install-dom0:
	@echo qvm-run -p $(CURRENT_DOMAIN) \
		"'cd $(DEV_VM_WORKDIR) && make cmd-install-domu'"

# ----------------------------------------------------------------------------
#  dom0
