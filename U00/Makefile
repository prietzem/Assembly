NASM=nasm
NASMFLAGS=-f elf64
CFLAGS=-std=c11 -Wall -Wextra -pedantic -O2
CPPFLAGS=-MMD -MF $@.d

program=gauss
obj-y=$(program).o gauss_wrapper.o

all: $(program)
$(program): $(obj-y)

-include *.d

%: %.o
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)

%.o: %.asm
	$(NASM) -o $@ $(NASMFLAGS) $<
%.o: %.c %.d
	$(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<

%.d: ;

clean:
	@$(RM) -fv $(program) $(obj-y) $(obj-y:=.d)

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: $(obj-y)
