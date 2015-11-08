RAGEL = ragel
RAGEL_FLAGS := -F0

COMPILE.rl = $(RAGEL) $(RAGEL_FLAGS)

%.c: %.rl
	$(COMPILE.rl) -C $(OUTPUT_OPTION) $<

VERSION=v1
GIT_DESC=$(shell test -d .git && git describe 2>/dev/null)

ifneq "$(GIT_DESC)" ""
VERSION=$(GIT_DESC)
endif

base_CFLAGS = -std=c11 -g \
	-Wall -Wextra -pedantic \
	-Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes \
	-D_GNU_SOURCE \
	-DENVOY_VERSION=\"$(VERSION)\"

CFLAGS := $(base_CFLAGS) $(CFLAGS)

VPATH = src

all: gpg-exec
gpg-exec: gpg-exec.o gpg-protocol.o util.o
gpg-protocol.o: $(VPATH)/gpg-protocol.c

install: gpg-exec
	install -Dm755 gpg-exec $(DESTDIR)/usr/bin/gpg-exec
	install -Dm644 man/gpg-exec.1 $(DESTDIR)/usr/share/man/man1/gpg-exec.1

clean:
	$(RM) gpg-exec *.o src/gpg-protocol.c

.PHONY: all clean install
