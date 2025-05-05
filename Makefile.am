# :set syn=automake noet ci pi sts=0 sw=4 ts=4
#
# TODO: a lot of this was just copy/pasted from the original makefile
# and it probably really needs to be refactored to be more automake-y
#
# TODO: some of the targets here are just helpers or wrappers around
# qubectl, and are maybe better placed in scripts or something


# prelim setup
AUTOMAKE_OPTIONS = subdir-objects -Wall -Werror foreign

# set some sane defaults
NAME    ?= $(basename $(CURDIR))
REPO    ?= $(NAME)
VERSION ?= "0.1.0"
RELEASE ?= "rc1"

COMMIT_SHA = $(shell git rev-parse --short HEAD)

# set some vars for automake
srcdir       = @srcdir@
VPATH        = @srcdir@
saltdir      = @datadir@/srv
licensesdir  = @datadir@/licenses
usersaltsdir = $(saltdir)/user

EXTRA_DIST = LICENSE LICENSE.md README.md scripts src $(PACKAGE).spec rpm_spec/$(PACKAGE).spec.in
SUBDIRS    = .


# automake dist definitions

dist_doc_DATA       = README
dist_licenses_DATA  = LICENSE
dist_usersalts_DATA = src/README \
  src/srv/mirage-os.top \
  src/srv/mirage-os.sls


# automake clean defs

DISTCLEANFILES  = @srcdir@/*.tar.gz
MAINTAINERCLEAN = @srcdir@/autom4te.cache \
  @srcdir@/$(PACKAGE).spec \
  @srcdir@/configure \
  @srcdir@/*.log \
  @srcdir@/.m4/*


# options for qubesctl and salt wrapper phonies

QUBESCTL_OPTS :=
QUBESCTL_OPTS += --force-color
QUBESCTL_OPTS += --show-output

SALTCALL_OPTS :=
SALTCALL_OPTS += -l $(or $(LOG_LEVEL), "error")


# run from dom0 against a domU with up-to-date repo
# during initial installation of the salts
.PHONY: cmd-minion-patch
cmd-minion-patch:
	@echo \
    qvm-run -p $(QUBE_NAME) \
    "'cat @abs_srcdir@/scripts/f_defaults.conf.patch'" \
    \| sudo patch /etc/salt/minion.d/f_defaults.conf

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

