CC = gcc
LD = gcc
RM = rm -rf
V  = 0

SOURCES =
OBJECTS = $(patsubst %.c, %.o, $SOURCES)

TARGET = evavm
SRCDIR = src
BINDIR = bin
OBJDIR = obj

CFLAGS := -lm
PREFIX := /usr/local

# Compiler Flags
ALL_CFLAGS		:= $(CFLAGS)
ALL_CFLAGS		+= -Wall -Wextra -pedantic -ansi
ALL_CFLAGS		+= -fno-strict-aliasing
ALL_CFLAGS		+= -Wuninitialized -Winit-self -Wfloat-equal
ALL_CFLAGS		+= -Wundef -Wshadow -Wc++-compat -Wcast-qual -Wcast-align
ALL_CFLAGS		+= -Wconversion -Wsign-conversion -Wjump-misses-init
ALL_CFLAGS		+= -Wno-multichar -Wpacked -Wstrict-overflow -Wvla
ALL_CFLAGS		+= -Wformat -Wno-format-zero-length -Wstrict-prototypes
ALL_CFLAGS		+= -Wno-unknown-warning-option

# Source, Binaries, Dependencies
SRC			:= $(shell find $(SRCDIR) -type f -name '*.c')
OBJ			:= $(patsubst $(SRCDIR)/%,$(OBJDIR)/%,$(SRC:.c=.o))
BIN			:= $(BINDIR)/$(TARGET)

# Verbosity for CC
REAL_CC 	:= $(CC)
CC_0 		= @echo "CC $<"; $(REAL_CC)
CC_1 		= $(REAL_CC)
CC 			= $(CC_$(V))

# Verbosity for LD
REAL_LD 	:= $(LD)
LD_0 		= @echo "LD $@"; $(REAL_LD)
LD_1 		= $(REAL_LD)
LD 			= $(LD_$(V))

# Verbosity for RM
REAL_RM 	:= $(RM)
RM_0 		= @echo "Cleaning..."; $(REAL_RM)
RM_1 		= $(REAL_RM)
RM 			= $(RM_$(V))

# Verbosity for RMDIR
REAL_RMDIR 	:= $(RMDIR)
RMDIR_0 	= @$(REAL_RMDIR)
RMDIR_1 	= $(REAL_RMDIR)
RMDIR 		= $(RMDIR_$(V))


# Build Rules
.PHONY: clean
.DEFAULT_GOAL := all

all: setup $(BIN)
setup: dir
remake: clean all

dir:
	@mkdir -p $(OBJDIR)
	@mkdir -p $(BINDIR)


$(BIN): $(OBJ)
	$(LD) $(ALL_LDFLAGS) $^ $(ALL_LDLIBS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(ALL_CFLAGS) $(ALL_CPPFLAGS) -c -MMD -MP -o $@ $<


install: $(BIN)
	$(INSTALL) -d $(PREFIX)/bin
	$(INSTALL) $(BIN) $(PREFIX)/bin

clean:
	$(RM) $(OBJ) $(DEP) $(BIN)
	$(RMDIR) $(OBJDIR) $(BINDIR) 2> /dev/null; true
