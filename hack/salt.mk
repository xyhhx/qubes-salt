SALT_ENV      ?= user
USER_SALT_DIR ?= $(HOME)/salt
USER_SALT_SRV ?= /srv/user

QUBESCTL_OPTS :=
QUBESCTL_OPTS += --force-color
QUBESCTL_OPTS += --show-output

# runs all highstates
# usage: make salt-highstate-all
.PHONY: salt-highstate-all
salt-highstate-all: check-is-dom0
	qubesctl $(QUBESCTL_OPTS) --all state.highstate saltenv=$(SALT_ENV)

# TODO: this doesn't work...
#
# runs highstate against given target(s)
# usage: TARGETS=provides-net make salt-highstate
.PHONY: salt-highstate
salt-highstate: check-is-dom0
	qubesctl $(QUBESCTL_OPTS) \
		--skip-dom0 \
		--targets $(TARGETS) \
		state.highstate \
		saltenv=$(SALT_ENV)

# runs a specific sls against given target(s)
# usage: TARGETS=provides-net make salt-sls templates.provides-net.configure
.PHONY: salt-sls
salt-sls: check-is-dom0
	qubesctl $(QUBESCTL_OPTS) \
		--skip-dom0 \
		--targets $(TARGETS) \
		state.sls \
		$(filter-out $@, $(MAKECMDGOALS)) \
		saltenv=$(SALT_ENV)

