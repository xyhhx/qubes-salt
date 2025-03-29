CURRENT_HOSTNAME := $(shell hostname)
CURRENT_PATH     := $(realpath .)

OUT_DIR	:= $(realpath $(CURRENT_PATH)/_out)

ifeq ($(CURRENT_HOSTNAME), "dom0")
	IS_DOM0 := true
else
	CURRENT_QUBESDB_NAME := $(shell qubesdb-read /name)
	IS_DOM0 := false
endif

include $(CURRENT_PATH)/hack/*.mk
