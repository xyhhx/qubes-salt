BUNDLE_FILE        ?= /tmp/salt.bundle
REMOTE_DOMAIN_PATH ?= /home/user/qubes-salts
USER_SALT_DIR      ?= $(HOME)/salt
USER_SALT_SRV      ?= /srv/user

CURRENT_HOSTNAME     := $(shell hostname)
CURRENT_PATH         := $(realpath .)

ifeq ($(CURRENT_HOSTNAME), "dom0")
	IS_DOM0 := true
else
	CURRENT_QUBESDB_NAME := $(shell qubesdb-read /name)
	IS_DOM0 := false
endif

# ============================================================================
# ----------------------------------------------------------------------------
# INSTALL COMMANDS
#
# these will print the commands to run for various installation related tasks
# ----------------------------------------------------------------------------

.PHONY: cmd-git-bundle
cmd-git-bundle:
	@echo \
		qvm-run -p $(CURRENT_QUBESDB_NAME) \
			"'cd $(CURRENT_PATH) && git bundle create - --all'" \
			\> $(BUNDLE_FILE)


.PHONY: cmd-minion-patch
cmd-minion-patch:
	@echo \
		qvm-run -p $(CURRENT_QUBESDB_NAME) \
		  "'cat $(CURRENT_PATH)/hack/f_defaults.conf.patch'" \
		  \| sudo patch /etc/salt/minion.d/f_defaults.conf


.PHONY: cmd-symlink-salts
cmd-symlink-salts:
	@echo ln -s $(USER_SALT_DIR) $(USER_SALT_SRV)

.PHONY:
cmd-install-domu: cmd-git-bundle cmd-minion-patch cmd-symlink-salts

.PHONY: cmd-install-dom0
cmd-install-dom0:
	@echo qvm-run -p $(CURRENT_QUBESDB_NAME) \
		"'cd $(CURRENT_PATH) && make cmd-install-domu'"

# ============================================================================
# ----------------------------------------------------------------------------
# dom0
#
# these tasks are intended to be run in dom0
# ----------------------------------------------------------------------------

.PHONY: check-is-dom0
check-is-dom0:
ifeq ($(IS_DOM0), "false")
	exit 1
endif

$(BUNDLE_FILE): get-bundle-from-domu

.PHONY: get-bundle-from-domu
get-bundle-from-domu: check-is-dom0
	qvm-run -p $(REMOTE_DOMAIN) \
		'cd $(REMOTE_DOMAIN_PATH) && git bundle create - --all' \
		> $(BUNDLE_FILE)

.PHONY: git-pull-from-bundle
git-pull-from-bundle: $(BUNDLE_FILE) check-is-dom0
	git pull --rebase

.PHONY: pull-changes
pull-changes: get-bundle-from-domu git-pull-from-bundle

.PHONY: salt-highstate-all
salt-highstate-all: check-is-dom0
	qubesctl --all state.highstate

.PHONY: salt-highstate
salt-highstate: check-is-dom0
	qubesctl --skip-dom0 --targets $$(TARGETS) state.highstate
