USER_SALT_DIR ?= /srv/user

SHA        := $(shell git describe --match=none --always --abbrev=8 --dirty)
TAG        := $(shell git describe --tag --always --dirty --match v[0-9]\*)
ABBREV_TAG := $(shell git describe --tags >/dev/null 2>/dev/null && git describe --tag --always --match v[0-9]\* --abbrev=0 || echo 'undefined')
BRANCH     := $(shell git rev-parse --abbrev-ref HEAD)
OUTDIR     := _out
SPECFILE   := user-salts.spec

.PHONY: install-dom0
install-dom0:
	install -D -m 0750 \
		src $(DESTDIR)$(USER_SALT_DIR)


$(OUTDIR)/$(SPECFILE):
	sed 's/@VERSION@/$(ABBREV_TAG)/' $(SPECFILE).in > $(OUTDIR)/$(SPECFILENAME)
