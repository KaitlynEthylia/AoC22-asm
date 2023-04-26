ASM=nasm
FORMAT=-f elf64

OBJDIR=obj
BINDIR=bin

SRCS=$(wildcard ./*/*.asm)
OBJS=$(patsubst ./%.asm,$(OBJDIR)/%.o,$(SRCS))
BINS=$(patsubst ./%.asm,$(BINDIR)/%,$(SRCS))

.PHONY: all clean

all: $(BINS)

$(OBJDIR)/%.o: %.asm
	@mkdir -p $(dir $@)
	$(ASM) $(FORMAT) $< -o $@

$(BINDIR)/%: $(OBJDIR)/%.o
	@mkdir -p $(dir $@)
	echo $(dir $@) | sed 's/bin\/\(.*\)/\1input/' | xargs -I . cp . $(dir $@)
	ld $< -o $@

clean:
	rm -rf $(OBJDIR)/* $(BINDIR)/*
