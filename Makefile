VERSION = 1.0.0
LIB := libhavltree.so.$(VERSION)
BIN := "test_h_avltree"

CFLAGS = -g -Wall -Werror -fPIC -shared
INCLUDE_PATH =

SRC := $(wildcard ./*.c)
OBJS := $(SRC:./%.c=./%.o)
LIB_OBJS := $(OBJS:./main.o=)
DEPS := $(SRC:./%.c=./%.d)
LIB_DEPS := $(DEPS:./main.d=)

all: $(LIB)

test: $(BIN)

clean:
	@rm -rf $(OBJS) $(LIB) $(BIN) $(DEPS)

ifeq ($(MAKECMDGOALS),test)
-include $(DEPS)
else ifneq ($(MAKECMDGOALS),clean)
-include $(LIB_DEPS)
endif

%.d: %.c
	$(CC) -MM -MT "$(subst .c,.o,${notdir $<}) $(subst .c,.d,${notdir $<})" -MF "$(subst .c,.d,${notdir $<})" $<

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDE_PATH) -c $< -o $@

$(LIB): $(LIB_OBJS)
	$(CC) $(CFLAGS) -o $@  $^

$(BIN): $(OBJS)
	$(CC) -o $@  $^

.PHONY: all clean test
