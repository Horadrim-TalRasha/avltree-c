VERSION = 1.0.0
LIB := libhavltree.so.$(VERSION)
BIN := "test_h_avltree"

CFLAGS = -g -Wall -Werror -fPIC -shared
INCLUDE_PATH =
LD_FLAGS =

SRC := $(wildcard ./*.c)
OBJS := $(SRC:./%.c=./%.o)
LIB_OBJS := $(OBJS:./main.o=)
DEPS := $(SRC:./%.c=./%.d)
LIB_DEPS := $(DEPS:./main.d=)
GCOV_OBJS := *.gcov *.gcda *.gcno
GCOV_RESULTS := *.info

all: $(LIB)

test: $(BIN)
	@valgrind --leak-check=full --show-reachable=yes -v ./$(BIN)
	@lcov -c -d ./ -o cover.info
	@lcov -a cover.info -o total.info

clean:
	@rm -rf $(OBJS) $(LIB) $(BIN) $(DEPS) $(GCOV_OBJS) $(GCOV_RESULTS)

ifeq ($(MAKECMDGOALS),test)
-include $(DEPS)
CFLAGS = -g -Wall -Werror -fprofile-arcs -ftest-coverage
LD_FLAGS = -fprofile-arcs -ftest-coverage
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
	$(CC) -o $@  $^ $(LD_FLAGS)

.PHONY: all clean test
