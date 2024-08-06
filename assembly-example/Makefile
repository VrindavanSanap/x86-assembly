
debug=-Fdwarf -g

all: code clean-no-ld-elf code-no-ld-elf hello_world

code: code.o
	ld -g -static -e _start --stats -o code code.o

code.o: code.nasm
	nasm -o code.o -f elf64 $(debug) code.nasm

clean-no-ld-elf: clean-no-ld-elf.nasm
	nasm -f bin -o clean-no-ld-elf clean-no-ld-elf.nasm
	chmod 755 clean-no-ld-elf

code-no-ld-elf: code-no-ld-elf.nasm
	nasm -f bin -o code-no-ld-elf code-no-ld-elf.nasm
	chmod 755 code-no-ld-elf

hello_world: hello_world.o
	ld -g -static -e _start --stats -o hello_world hello_world.o

hello_world.o: hello_world.nasm
	nasm -o hello_world.o -f elf64 $(debug) hello_world.nasm

clean:
	@rm -f  code code.o  clean-no-ld-elf clean-no-ld-elf.o  code-no-ld-elf code-no-ld-elf.o  hello_world hello_world.o

