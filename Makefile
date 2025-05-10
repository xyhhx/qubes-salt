SHELL = /bin/sh
.POSIX:

REPO := qubes-mgmt-salt-user

BUNDLE_FILE   ?= /tmp/salt.bundle
GUEST_WORKDIR ?= /home/user/$(REPO)
SRC						?= $(HOME)/.config/$(REPO)
SRV           ?= /srv/user

HOSTNAME := $(shell hostname)
PWD      := $(realpath .)

QUBESCTL_OPTS :=
QUBESCTL_OPTS += --force-color
QUBESCTL_OPTS += --show-output

SALTCALL_OPTS :=
SALTCALL_OPTS += -l $(or $(LOG_LEVEL), "error")

ifeq ($(HOSTNAME), "dom0")
	QUBE_NAME := $(shell qubesdb-read /name)
endif

# ============================================================================
# ----------------------------------------------------------------------------
# INSTALL COMMANDS
# ----------------------------------------------------------------------------

install: $(SRV)

$(SRV): $(SRC)
	ln -s $(SRV) $(SRC)

$(SRC): $(BUNDLE_FILE)
	git pull --rebase

$(BUNDLE_FILE): check-is-dom0
	qvm-run -p $(DOM_U) \
	'cd $(GUEST_WORKDIR) && git bundle create - --all' \
	\> $(BUNDLE_FILE)

.PHONY: cmd-minion-patch
cmd-minion-patch:
	@echo \
	qvm-run -p $(QUBE_NAME) \
	"'cat $(PWD)/scripts/f_defaults.conf.patch'" \
	\| sudo patch /etc/salt/minion.d/f_defaults.conf

# ============================================================================
# ----------------------------------------------------------------------------
# dom0
#
# these tasks are intended to be run in dom0
# ----------------------------------------------------------------------------

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
	'cd $(GUEST_WORKDIR) && git bundle create - --all' \
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

# runs all applys
# usage: make salt-apply-all
.PHONY: salt-apply-all
salt-apply-all: check-is-dom0
	qubesctl $(QUBESCTL_OPTS) --all state.apply $(SALTCALL_OPTS)


# usage: TARGETS=provides-net make salt-apply
.PHONY: salt-apply
salt-apply: check-is-dom0
	qubesctl $(QUBESCTL_OPTS) \
	--target $(TARGETS) \
	state.apply \
	$(SALTCALL_OPTS)

# runs a specific sls against given target(s)
# usage: TARGETS=provides-net make salt-sls templates.provides-net.configure
.PHONY: salt-sls
salt-sls: check-is-dom0
	qubesctl $(QUBESCTL_OPTS) \
	--skip-dom0 \
	--target $(TARGETS) \
	state.sls \
	$(filter-out $@, $(MAKECMDGOALS)) \
	$(SALTCALL_OPTS) \
	saltenv=user


