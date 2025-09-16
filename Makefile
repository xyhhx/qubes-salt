ifeq (,$(wildcard .env))
include .env
endif

SHELL = /bin/bash
.POSIX_SHELL:

PROJECT_NAME					 := qubes-mgmt-salt-user
USR_LOCAL    					 := /usr/local
SRC_DIR			 					 := $(USR_LOCAL)/src/$(PROJECT_NAME)
MINION_CONF_DIR_GLOBAL := /etc/salt/minion.d/z_user.conf
MINION_CONF_DIR_USER   := $(USR_LOCAL)/etc/salt/minion.d

.PHONY: install
install: $(MINION_CONF_DIR_GLOBAL)/z_user.conf $(MINION_CONF_DIR_USER)/overrides.conf

clean:
	rm -f $(MINION_CONF_DIR_GLOBAL)/z_user.conf $(MINION_CONF_DIR_USER)/overrides.conf

bundle:
	mkdir -p .bundles
	git bundle create - --all > .bundles/qubes-mgmt-salt-user

$(MINION_CONF_DIR_GLOBAL)/z_user.conf:
	install -D -oroot -groot -m0644 conf/z_user.conf $(MINION_CONF_DIR_GLOBAL)/z_user.conf

$(MINION_CONF_DIR_USER)/overrides.conf:
	install -D -oroot -groot -m0644 conf/overrides.conf $(MINION_CONF_DIR_USER)/overrides.conf

