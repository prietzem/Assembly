NASM=nasm
NASMFLAGS=-f elf64 $(XNASMFLAGS)
CFLAGS=-std=c11 -Wall -Wextra -pedantic -O2 $(XCFLAGS)
CPPFLAGS=-MMD -MF $*.d

program=convert
obj-y=$(program).o convert_wrapper.o

all: $(program)
$(program): $(obj-y)

-include *.d

# pattern rules
%: %.o
	$(CC) -o $@ $(LDFLAGS) $^ $(LDLIBS)

%.o: %.asm
	$(NASM) -o $@ $(NASMFLAGS) $<
%.o: %.c
	$(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<

%.d: ;

clean:
	@$(RM) -fv $(program) $(obj-y) $(obj-y:.o=.d)

.SUFFIXES:
.PHONY: all clean
.PRECIOUS: $(obj-y)
