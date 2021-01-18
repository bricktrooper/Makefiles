include config.mk

VPATH += $(INC)

MMFLAGS += $(addprefix -I , $(INC))
CCFLAGS += $(addprefix -I , $(INC))

OBJ := $(SRC:.c=.o)
DEP := $(SRC:.c=.d)

$(shell find . -type d -name out -prune -o -type d -print | xargs printf -- '$(ART)/%s\n' | xargs mkdir -p)

$(ART)/$(EXE): $(addprefix $(ART)/, $(OBJ))
	@echo "LD   $(OBJ)"
	@$(LD) $(LDLIBS) $(LDFLAGS) $^ -o $@
	@echo "EXE  $(EXE)"

$(ART)/%.o: %.c
	@echo "CC   $<"
	@$(CC) $(CCFLAGS) -c $< -o $@

$(ART)/%.d: %.c
	@$(MM) $(MMFLAGS) -MM $< -MT $(subst .d,.o,$@) -MF $@

$(ART)/%.o: %.m
	@echo "CC   $<"
	@$(CC) $(CCFLAGS) -c $< -o $@

$(ART)/%.d: %.m
	@$(MM) $(MMFLAGS) -MM $< -MT $(subst .d,.o,$@) -MF $@

-include $(addprefix $(ART)/, $(DEP))

clean:
	@for ARTIFACT in $(notdir $(wildcard $(ART)/*)); do echo "RM   $$ARTIFACT"; done
	@rm -rf $(ART)
