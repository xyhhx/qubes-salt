BUNDLE_FILE        ?= /tmp/salt.bundle
REMOTE_DOMAIN_PATH ?= /home/user/qubes-salts
USER_SALT_DIR      ?= $(HOME)/.config/qubes-qubes-mgmt-salt-user
USER_SALT_SRV      ?= /srv/user

CURRENT_HOSTNAME := $(shell hostname)
CURRENT_PATH     := $(realpath .)

QUBESCTL_OPTS :=
QUBESCTL_OPTS += --force-color
QUBESCTL_OPTS += --show-output

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
      "'cat $(CURRENT_PATH)/scripts/f_defaults.conf.patch'" \
      \| sudo patch /etc/salt/minion.d/f_defaults.conf


.PHONY: cmd-symlink-salts
cmd-symlink-salts:
  @echo ln -s $(USER_SALT_DIR) $(USER_SALT_SRV)

# this prints the commands to run from dom0
.PHONY:
cmd-install-domu: cmd-git-bundle cmd-minion-patch cmd-symlink-salts

# run this in dom0
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

# runs all highstates
# usage: make salt-highstate-all
.PHONY: salt-highstate-all
salt-highstate-all: check-is-dom0
  qubesctl $(QUBESCTL_OPTS) --all state.highstate

# TODO: this doesn't work...
#
# runs highstate against given target(s)
# usage: TARGETS=provides-net make salt-highstate
.PHONY: salt-highstate
salt-highstate: check-is-dom0
  qubesctl $(QUBESCTL_OPTS) \
    --skip-dom0 \
    --targets $(TARGETS) \
    state.highstate

# runs a specific sls against given target(s)
# usage: TARGETS=provides-net make salt-sls templates.provides-net.configure
.PHONY: salt-sls
salt-sls: check-is-dom0
  qubesctl $(QUBESCTL_OPTS) \
    --skip-dom0 \
    --targets $(TARGETS) \
    state.sls \
    $(filter-out $@, $(MAKECMDGOALS)) \
    saltenv=user
