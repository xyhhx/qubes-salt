SHELL = /bin/bash
.POSIX_SHELL:

SALTENV ?= user

PROJECT_NAME					 := qubes-mgmt-salt-user
USR_LOCAL    					 := /usr/local
SRC_DIR			 					 := $(USR_LOCAL)/src/$(PROJECT_NAME)
MINION_CONF_DIR_GLOBAL := /etc/salt/minion.d
MINION_CONF_DIR_USER   := $(USR_LOCAL)/etc/salt/minion.d

QUBESCTL := qubesctl
QUBESCTL += --show-output
QUBESCTL += --force-color
QUBESCTL += $(if $(SKIP_DOM0), --skip-dom0)
QUBESCTL += $(if $(TARGETS), --targets $(TARGETS))

comma := ,
empty :=
space := $(empty) $(empty)

ALL_TOPS     := $(shell ls -1 qubes-mgmt-salt-user/*.top | sed 's/.*\/\(.*\)\.top/\1/')
TARGET_TYPES := all templates standalones apps

ifeq (apply, $(firstword $(MAKECMDGOALS)))
	TARGETS       := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
	VM_TARGETS    := $(subst $(space),$(comma),$(filter-out $(TARGET_TYPES),$(TARGETS)))
	BATCH_TARGETS := $(foreach wrd,$(filter $(TARGET_TYPES),$(TARGETS)),--$(wrd))
endif

# ----------
#  task guards

.PHONY: guard-host-%
guard-host-%:
	@ if [ "`hostname`" != "${*}" ]; then \
		echo "Task must be in run in ${*}"; \
		exit 1; \
	fi

.PHONY: guest-env-%
guard-env-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Required environment variable ${*} not set"; \
		exit 1; \
	fi

.PHONY: guard-domu
guard-domu:
	@ if [ "`hostname`" == "`qubesdb-read /name`" ]; then \
		echo "This task must be run in a guest domain"; \
		exit 1; \
	fi

# ----------
#  dom0

.PHONY: install
install: guard-host-dom0 $(MINION_CONF_DIR_GLOBAL)/z_user.conf $(MINION_CONF_DIR_USER)/overrides.conf /srv/$(SALTENV)/salt
	$(MAKE) lift-bundle

.PHONY: clean
clean: guard-host-dom0
	rm -f $(MINION_CONF_DIR_GLOBAL)/z_user.conf $(MINION_CONF_DIR_USER)/overrides.conf

.PHONY: pull-bundle
pull-bundle: guard-host-dom0 guard-env-GUEST $(SRC_DIR)/.bundles
	qvm-run -- $(GUEST) 'cd $(SRC_DIR) && make bundle'
	qvm-run -p -- $(GUEST) 'cat $(SRC_DIR)/.bundles/$(PROJECT_NAME)' | run0 tee $(SRC_DIR)/.bundles/$(PROJECT_NAME)  >/dev/null
	git pull --rebase

.PHONY: apply
apply: guard-host-dom0 guard-env-GUEST
	run0 $(QUBESCTL) $(if $(TARGETS),--targets $(VM_TARGETS)) $(BATCH_TARGETS) state.apply $(if $(DEBUG),-l debug)

.PHONY: enable
enable: guard-host-dom0 guard-env-GUEST
	run0 $(QUBESCTL) top.$@ $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: disable
disable: guard-host-dom0 guard-env-GUEST
	run0 $(QUBESCTL) top.$@ $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

.PHONY: enable-all
enable-all: guard-host-dom0 guard-env-GUEST
	run0 $(QUBESCTL) top.enable $(ALL_TOPS)

.PHONY: disable-all
disable-all: guard-host-dom0 guard-env-GUEST
	run0 $(QUBESCTL) top.disable $(ALL_TOPS)

.PHONY: enable-only
enable-only: guard-host-dom0 guard-env-GUEST disable-all enable

.PHONY: render
render: guard-host-dom0
	run0 $(QUBESCTL) slsutil.renderer $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS)) default_renderer=jinja

$(MINION_CONF_DIR_GLOBAL)/z_user.conf:
	install -D -oroot -groot -m0644 conf/z_user.conf $@

$(MINION_CONF_DIR_USER)/overrides.conf:
	install -D -oroot -groot -m0644 conf/overrides.conf $@

$(SRC_DIR)/.bundles:
	install -dD -oroot -groot -m0755 $@

/srv/$(SALTENV)/salt:
	install -Dd -o$(USER) -g$(USER) -m0755 /srv/$(SALTENV)
	ln -s $(SRC_DIR)/$(PROJECT_NAME) $@

# ----------
#  domU

bundle: guard-domu
	mkdir -p .bundles
	git bundle create - --all > .bundles/qubes-mgmt-salt-user

%:
	@:
