SHELL = /bin/bash
.POSIX_SHELL:

SALTENV ?= user

PROJECT_NAME					 := qubes-mgmt-salt-user
USR_LOCAL    					 := /usr/local
SRC_DIR			 					 := $(USR_LOCAL)/src/$(PROJECT_NAME)
MINION_CONF_DIR_GLOBAL := /etc/salt/minion.d
MINION_CONF_DIR_USER   := $(USR_LOCAL)/etc/salt/minion.d

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

.PHONY: lift-bundle
lift-bundle: guard-host-dom0 guard-env-GUEST $(SRC_DIR)/.bundles
	qvm-run $(GUEST) 'cd $(SRC_DIR) && make bundle'
	qvm-run -p $(GUEST) 'cat $(SRC_DIR)/.bundles/$(PROJECT_NAME)' > $(SRC_DIR)/.bundles/$(PROJECT_NAME) </dev/null

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
