
BUNDLE_FILE        ?= /tmp/salt.bundle

REMOTE_DOMAIN_PATH ?= /home/user/qubes-salts

# TODO: should this be a macro?
#
# checks if make is running in dom0. really shouldn't be called manually
# usage: make check-is-dom0
.PHONY: check-is-dom0
check-is-dom0:
ifeq ($(IS_DOM0), "false")
	exit 1
endif

$(BUNDLE_FILE): get-bundle-from-domu

# TODO: should this be a macro?
#
# ephemerally creates a git bundle in the configured $REMOTE_DOMAIN, and
# copies it into $BUNDLE_FILE (/tmp/salt.bundle by default)
# usage: make get-bundle-from-domu
.PHONY: get-bundle-from-domu
get-bundle-from-domu: check-is-dom0
	qvm-run -p $(REMOTE_DOMAIN) \
		'cd $(REMOTE_DOMAIN_PATH) && git bundle create - --all' \
		> $(BUNDLE_FILE)

# TODO: should this be a macro?
#
# wrapper around `git pull --rebase`
# usage: make git-pull
.PHONY: git-pull
git-pull: $(BUNDLE_FILE) check-is-dom0
	git pull --rebase

# pulls changes from the configured domU. wrapper around get-bundle-from-domu
# and git-pull
# usage: make pull
.PHONY: pull
pull: get-bundle-from-domu git-pull
