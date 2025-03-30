# set some common vars
CURRENT_HOSTNAME := $(shell hostname)
CURRENT_PATH     := $(realpath .)
WORKDIR          := $(CURRENT_PATH)
OUT_DIR	  			 := $(WORKDIR)/_out
SPEC_TPL  			 := $(WORKDIR)/rpm_spec/qubes-user-salt.spec.in
SRC_DIR					 := $(WORKDIR)/src
TMP              := $(shell mktemp -d /tmp/qubes-user-salt-XXXXXX-buildroot)

# set some vars that if they're unset
BUNDLE_FILE        ?= /tmp/salt.bundle
REMOTE_DOMAIN_PATH ?= /home/user/qubes-user-salt
SALT_ENV					 ?= user
USER_SALT_DIR 		 ?= $(HOME)/salt
USER_SALT_SRV 		 ?= /srv/user

# save some values collected from git
SHA        := $(shell git describe --match=none --always --abbrev=8)
TAG        := $(shell git describe --tag --always --match v[0-9]\* --abbrev)
FULL_TAG   := $(shell git describe --tags >/dev/null 2>/dev/null && git describe --tag --always --match v[0-9]\* --abbrev=0 || echo 'undefined')
BRANCH     := $(shell git rev-parse --abbrev-ref HEAD)

# common args for the tito cli
TITO_ARGS :=
TITO_ARGS += --offline
TITO_ARGS += -o $(OUT_DIR)
TITO_ARGS += --no-sudo
TITO_ARGS += --quiet
TITO_ARGS += --ignore-missing-config

# common opts for qubectl
QUBESCTL_OPTS :=
QUBESCTL_OPTS += --force-color
QUBESCTL_OPTS += --show-output

# set up vars for the spec file
export NAME    ?= $(notdir $(CURDIR))
export VERSION ?= $(shell cat $(WORKDIR)/VERSION)
export RELEASE ?= 1%{?dist}

ifeq ($(CURRENT_HOSTNAME), "dom0")
CURRENT_QUBESDB_NAME := "dom0"
IS_DOM0 := true
else
CURRENT_QUBESDB_NAME := $(shell qubesdb-read /name)
IS_DOM0 := false
endif

.PHONY: verify-sources
verify-sources:
	git tag -v `git describe`

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)

$(OUT_DIR)/$(NAME).spec: generate-pkg-spec
$(OUT_DIR)/Makefile: generate-pkg-makefile

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

build: verify-sources generate-pkg-spec generate-pkg-makefile
	cp -r $(SRC_DIR) $(OUT_DIR)
	pushd $(OUT_DIR) && \
		tito build --rpm $(TITO_ARGS) && \
		popd
	@printf "\n\n%s\n" "Built the package to $(OUT_DIR)"
	@-tree "$(OUT_DIR)"

generate-pkg-makefile: $(OUT_DIR)
	printf \
		"USER_SALT_SRV ?= /srv/user\n\n.PHONY: install\ninstall:\n%s" \
		"`find $(SRC_DIR) -type f -printf '\tinstall -m0644 -D src/%P $$(DESTDIR)$$(USER_SALT_SRV)/%P\n'`" \
		> $(OUT_DIR)/Makefile

generate-pkg-spec: $(OUT_DIR)
	@echo "generating ${NAME}.spec for version: ${VERSION} and release: ${RELEASE}"
	tail -n +2 "${SPEC_TPL}" | envsubst '$${NAME} $${VERSION} $${RELEASE}' > $(OUT_DIR)/qubes-user-salt.spec

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

# installs the salt states
.PHONY: install
install: check-is-dom0
	install -D -m0644 src/pillar/names.sls $(DESTDIR)$(USER_SALT_SRV)/pillar/names.sls
	install -D -m0644 src/pillar/top.sls $(DESTDIR)$(USER_SALT_SRV)/pillar/top.sls

	install -D -m0644 src/salt/dvm-browsers-fedora.top $(DESTDIR)$(USER_SALT_SRV)/salt/dvm-browsers-fedora.top
	install -D -m0644 src/salt/on-debian-12-minimal.top $(DESTDIR)$(USER_SALT_SRV)/salt/on-debian-12-minimal.top
	install -D -m0644 src/salt/on-fedora-40-minimal.top $(DESTDIR)$(USER_SALT_SRV)/salt/on-fedora-40-minimal.top
	install -D -m0644 src/salt/on-fedora-40-xfce.top $(DESTDIR)$(USER_SALT_SRV)/salt/on-fedora-40-xfce.top
	install -D -m0644 src/salt/on-fedora-41-minimal.top $(DESTDIR)$(USER_SALT_SRV)/salt/on-fedora-41-minimal.top
	install -D -m0644 src/salt/on-kicksecure-17.top $(DESTDIR)$(USER_SALT_SRV)/salt/on-kicksecure-17.top
	install -D -m0644 src/salt/provides-audio.top $(DESTDIR)$(USER_SALT_SRV)/salt/provides-audio.top
	install -D -m0644 src/salt/provides-browsers-on-fedora.top $(DESTDIR)$(USER_SALT_SRV)/salt/provides-browsers-on-fedora.top
	install -D -m0644 src/salt/provides-ivpn.top $(DESTDIR)$(USER_SALT_SRV)/salt/provides-ivpn.top
	install -D -m0644 src/salt/provides-net.top $(DESTDIR)$(USER_SALT_SRV)/salt/provides-net.top
	install -D -m0644 src/salt/provides-onlykey.top $(DESTDIR)$(USER_SALT_SRV)/salt/provides-onlykey.top
	install -D -m0644 src/salt/provides-usb.top $(DESTDIR)$(USER_SALT_SRV)/salt/provides-usb.top
	install -D -m0644 src/salt/sys-onlykey.top $(DESTDIR)$(USER_SALT_SRV)/salt/sys-onlykey.top
	install -D -m0644 src/salt/sys-vpn-ivpn.top $(DESTDIR)$(USER_SALT_SRV)/salt/sys-vpn-ivpn.top

	install -D -m0644 src/salt/appvms/sys-vpn-ivpn/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/appvms/sys-vpn-ivpn/vm.sls

	install -D -m0644 src/salt/appvms/sys-onlykey/configure.sls $(DESTDIR)$(USER_SALT_SRV)/salt/appvms/sys-onlykey/configure.sls
	install -D -m0644 src/salt/appvms/sys-onlykey/files/49-onlykey.policy $(DESTDIR)$(USER_SALT_SRV)/salt/appvms/sys-onlykey/files/49-onlykey.policy
	install -D -m0644 src/salt/appvms/sys-onlykey/files/ok-proxy-ssh-agent $(DESTDIR)$(USER_SALT_SRV)/salt/appvms/sys-onlykey/files/ok-proxy-ssh-agent
	install -D -m0644 src/salt/appvms/sys-onlykey/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/appvms/sys-onlykey/vm.sls

	install -D -m0644 src/salt/dom0/user-settings.sls $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/user-settings.sls
	install -D -m0644 src/salt/dom0/policies.sls $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/policies.sls
	install -D -m0644 src/salt/dom0/configure.top $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/configure.top
	install -D -m0644 src/salt/dom0/files/35-peripherals.policy $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/files/35-peripherals.policy
	install -D -m0644 src/salt/dom0/files/30-sys-gui.policy $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/files/30-sys-gui.policy
	install -D -m0644 src/salt/dom0/files/35-ssh.policy $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/files/35-ssh.policy
	install -D -m0644 src/salt/dom0/files/35-gpg.policy $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/files/35-gpg.policy
	install -D -m0644 src/salt/dom0/files/10-custom.policy $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/files/10-custom.policy
	install -D -m0644 src/salt/dom0/files/30-sys-audio.policy $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/files/30-sys-audio.policy
	install -D -m0644 src/salt/dom0/files/center-window-xfce.sh $(DESTDIR)$(USER_SALT_SRV)/salt/dom0/files/center-window-xfce.sh

	install -D -m0644 src/salt/templates/on-debian-12-minimal/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/on-debian-12-minimal/vm.sls

	install -D -m0644 src/salt/templates/provides-net/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-net/vm.sls

	install -D -m0644 src/salt/templates/on-fedora-40-minimal/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/on-fedora-40-minimal/vm.sls

	install -D -m0644 src/salt/templates/on-fedora-41-minimal/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/on-fedora-41-minimal/vm.sls

	install -D -m0644 src/salt/templates/provides-onlykey/configure.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-onlykey/configure.sls
	install -D -m0644 src/salt/templates/provides-onlykey/files/49-onlykey.rules $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-onlykey/files/49-onlykey.rules
	install -D -m0644 src/salt/templates/provides-onlykey/files/onlykey.SshAgent $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-onlykey/files/onlykey.SshAgent
	install -D -m0644 src/salt/templates/provides-onlykey/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-onlykey/vm.sls

	install -D -m0644 src/salt/templates/provides-ivpn/configure.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/configure.sls
	install -D -m0644 src/salt/templates/provides-ivpn/files/50_user.conf $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/files/50_user.conf
	install -D -m0644 src/salt/templates/provides-ivpn/files/dnat-to-ns.path $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/files/dnat-to-ns.path
	install -D -m0644 src/salt/templates/provides-ivpn/files/dnat-to-ns.service $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/files/dnat-to-ns.service
	install -D -m0644 src/salt/templates/provides-ivpn/files/ivpn.repo $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/files/ivpn.repo
	install -D -m0644 src/salt/templates/provides-ivpn/files/systemd_override.conf $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/files/systemd_override.conf
	install -D -m0644 src/salt/templates/provides-ivpn/files/dnat-to-ns-boot.service $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/files/dnat-to-ns-boot.service
	install -D -m0644 src/salt/templates/provides-ivpn/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-ivpn/vm.sls

	install -D -m0644 src/salt/templates/provides-audio/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-audio/vm.sls

	install -D -m0644 src/salt/templates/provides-browsers-on-fedora/configure.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-browsers-on-fedora/configure.sls
	install -D -m0644 src/salt/templates/provides-browsers-on-fedora/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-browsers-on-fedora/vm.sls

	install -D -m0644 src/salt/templates/on-fedora-40-xfce/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/on-fedora-40-xfce/vm.sls

	install -D -m0644 src/salt/templates/provides-usb/configure.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-usb/configure.sls
	install -D -m0644 src/salt/templates/provides-usb/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/provides-usb/vm.sls

	install -D -m0644 src/salt/templates/on-kicksecure-17/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/templates/on-kicksecure-17/vm.sls

	install -D -m0644 src/salt/common/https_proxy.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/https_proxy.sls
	install -D -m0644 src/salt/common/install-kicksecure.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/install-kicksecure.sls
	install -D -m0644 src/salt/common/locale.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/locale.sls

	install -D -m0644 src/salt/common/theme/fonts.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/theme/fonts.sls
	install -D -m0644 src/salt/common/theme/init.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/theme/init.sls
	install -D -m0644 src/salt/common/theme/icon-themes.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/theme/icon-themes.sls
	install -D -m0644 src/salt/common/theme/gtk-themes.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/theme/gtk-themes.sls

	install -D -m0644 src/salt/common/terminal/init.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/terminal/init.sls
	install -D -m0644 src/salt/common/terminal/fedora.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/terminal/fedora.sls
	install -D -m0644 src/salt/common/terminal/debian.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/terminal/debian.sls

	install -D -m0644 src/salt/common/terminal/files/alacritty.toml $(DESTDIR)$(USER_SALT_SRV)/salt/common/terminal/files/alacritty.toml
	install -D -m0644 src/salt/common/terminal/files/alacritty.yml $(DESTDIR)$(USER_SALT_SRV)/salt/common/terminal/files/alacritty.yml

	install -D -m0644 src/salt/common/pkgs/hardened_malloc.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/pkgs/hardened_malloc.sls
	install -D -m0644 src/salt/common/pkgs/audio.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/pkgs/audio.sls
	install -D -m0644 src/salt/common/pkgs/network.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/pkgs/network.sls
	install -D -m0644 src/salt/common/pkgs/common.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/pkgs/common.sls
	install -D -m0644 src/salt/common/pkgs/audiovm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/pkgs/audiovm.sls
	install -D -m0644 src/salt/common/pkgs/netvm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/common/pkgs/netvm.sls

	install -D -m0644 src/salt/dispvms/dvm-browsers-fedora/configure.sls $(DESTDIR)$(USER_SALT_SRV)/salt/dispvms/dvm-browsers-fedora/configure.sls
	install -D -m0644 src/salt/dispvms/dvm-browsers-fedora/vm.sls $(DESTDIR)$(USER_SALT_SRV)/salt/dispvms/dvm-browsers-fedora/vm.sls

	install -D -m0644 src/salt/utils/macros/create_template.sls $(DESTDIR)$(USER_SALT_SRV)/salt/utils/macros/create_template.sls
