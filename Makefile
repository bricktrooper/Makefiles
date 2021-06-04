# ======= IMPORT CONFIGURATION ======= #

include config.mk

# ======= VERIFY CONFIGURATION ======= #

ifeq ($(CC), )
$(error CC was not specified)
endif

ifeq ($(LD), )
$(error LD was not specified)
endif

ifeq ($(MM), )
$(error MM was not specified)
endif

ifeq ($(ART), )
$(error ART was not specified)
endif

ifeq ($(EXE), )
$(error EXE was not specified)
endif

ifeq ($(DIR), )
$(error DIR was not specified)
endif

# ======= PROCESS CONFIGURATION ======= #

DIR := $(patsubst .,,$(DIR))

VPATH += $(DIR)

MMFLAGS += -I .
MMFLAGS += $(addprefix -I , $(DIR))

CCFLAGS += -I .
CCFLAGS += $(addprefix -I , $(DIR))

SRC = $(wildcard *.c)
SRC += $(wildcard $(addsuffix /*.c, $(DIR)))

OBJ := $(SRC:.c=.o)
DEP := $(SRC:.c=.d)

OBJ := $(addprefix $(ART)/, $(OBJ))

# ======= CREATE ARTIFACTS DIRECTORY ======= #

$(shell mkdir -p $(addprefix $(ART)/, $(DIR)))

# ======= LINK ======= #

$(ART)/$(EXE): $(OBJ)
	@echo "LD   $(OBJ)"
	@$(LD) $(LDLIBS) $(LDFLAGS) $^ -o $@
	@echo "EXE  $(EXE)"

# ======= COMPILE ======= #

$(ART)/%.o: %.c
	@echo "CC   $<"
	@$(CC) $(CCFLAGS) -c $< -o $@

# ======= GENERATE DEPENDENCIES ======= #

$(ART)/%.d: %.c
	@$(MM) $(MMFLAGS) -MM $< -MT $(subst .d,.o,$@) -MF $@

-include $(addprefix $(ART)/, $(DEP))

# ======= CLEAN ======= #

clean:
	@echo "RM   $(ART)/"
	@rm -rf $(ART)
