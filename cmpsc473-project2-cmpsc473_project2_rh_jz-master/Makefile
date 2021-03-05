TARGET = mdriver
OBJS += memlib.o
OBJS += fcyc.o
OBJS += clock.o
OBJS += stree.o
OBJS += mdriver.o
OBJS += mm.o
LIBS += -lm -lrt

CC = gcc
CFLAGS += -MMD -MP # dependency tracking flags
CFLAGS += -I./
CFLAGS += -std=gnu99 -Wall -Wextra -Werror -Wno-unused-function -Wno-unused-parameter
CFLAGS += -DDRIVER
LDFLAGS += $(LIBS)

all: CFLAGS += -g -O3 # release flags
all: $(TARGET)

release: clean all

debug: CFLAGS += -g -O0 -D_GLIBC_DEBUG # debug flags
debug: clean $(TARGET)

$(TARGET): $(OBJS)
	@chmod +x *.pl
	@sed -i -e 's/\r$$//g' *.pl # dos to unix
	@sed -i -e 's/\r/\n/g' *.pl # mac to unix
	-@./macro-check.pl -f mm.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

DEPS = $(OBJS:%.o=%.d)
-include $(DEPS)

clean:
	-@rm $(TARGET) $(OBJS) $(DEPS) tput_* 2> /dev/null || true

test:
	@chmod +x *.pl
	@sed -i -e 's/\r$$//g' *.pl # dos to unix
	@sed -i -e 's/\r/\n/g' *.pl # mac to unix
	-@./driver.pl
