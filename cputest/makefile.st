
NOWDATE := "\"$(shell date "+%-d.%-m.%Y")\""
NOWTIME := "\"$(shell date "+%T")\""

CC=/opt/m68k-atari/bin/m68k-atari-mint-gcc
AS=/opt/m68k-atari/bin/m68k-atari-mint-as

CFLAGS = -O2 -m68000 -fomit-frame-pointer -msoft-float -DREVDATE=$(NOWDATE) -DREVTIME=$(NOWTIME) -DM68K -DWAITEXIT
LINK_CFLAGS = -lm -s

OBJS = main.o asm040.o atari.o \
	decode_ea.o globals.o opcode_handler_cpu.o opcode_handler_fpu.o \
	opcode_handler_mmu.o opcodes_cpu.o opcodes_fpu.o opcodes_mmu.o util.o

all: $(OBJS)
	$(CC) $(LINK_CFLAGS) -o cputest.ttp $^

main.o: main.c
	$(CC) $(CFLAGS) -I. -c -o $@ main.c

decode_ea.o: adis/decode_ea.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/decode_ea.c

globals.o: adis/globals.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/globals.c

opcode_handler_cpu.o: adis/opcode_handler_cpu.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/opcode_handler_cpu.c

opcode_handler_fpu.o: adis/opcode_handler_fpu.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/opcode_handler_fpu.c

opcode_handler_mmu.o: adis/opcode_handler_mmu.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/opcode_handler_mmu.c

opcodes_cpu.o: adis/opcodes_cpu.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/opcodes_cpu.c

opcodes_fpu.o: adis/opcodes_fpu.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/opcodes_fpu.c

opcodes_mmu.o: adis/opcodes_mmu.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/opcodes_mmu.c

util.o: adis/util.c
	$(CC) $(CFLAGS) -I. -c -o $@ adis/util.c

asm040.o: asm040.S
	$(AS) -m68020  -o $@ asm040.S

atari.o: atari.S
	$(AS) -m68020  -o $@ atari.S