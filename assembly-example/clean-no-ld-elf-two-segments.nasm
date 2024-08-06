
	;; inspired by http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html
	;;             https://blog.stalkr.net/2014/10/tiny-elf-3264-with-nasm.html
	;;             ... and others of similar ilk

	
BITS 64

ORG 0x400000

;;;
;;;  Definitions from "ELF-64 Object File Format" (aka "EOFF document"):
;;;
;;;
;;;      Elf64_Addr    8 bytes, aligned on 8 bytes	; program address
;;;      Elf64_Off     8 bytes, aligned on 8 bytes	; file offset
;;;      Elf64_Half    2 bytes, aligned on 2 bytes	; medium integer
;;;      Elf64_Word    4 bytes, aligned on 4 bytes	; integer
;;;      Elf64_Sword   4 bytes, aligned on 4 bytes	; signed integer
;;;      Elf64_Xword   8 bytes, aligned on 8 bytes      ; long integer
;;;      Elf64_Sxword  8 bytes, aligned on 8 bytes      ; signed long integer
;;;      unsigned char 1 byte, aligned on 1 byte	; small integer
	

elf64_file_header:		; This is often just called the elf64 header

	;; at 0: unsigned char e_ident[16]
	db 127,"ELF"		; e_ident[0-3]: EI_MAG{0,1,2,3} (aka "magic number")
	db 2			; e_ident[4]: EI_CLASS; ELFCLASS32=1, ELFCLASS64=2 (aka "File class")
	db 1			; e_ident[5]: EI_DATA; ELFDATALSB=1, ELFDATAMSB=2 (aka "Data encoding")
	db 1			; e_ident[6]: EI_VERSION; EV_CURRENT=1 (aka "File version")
	db 3			; e_ident[7]: EI_OSABI; ELFOSABI_SYSV=0 (aka "OS/ABI identification")
	   			; e_ident[7]: EI_OSABI; ELFOSABI_LINUX=3 (trying this..., trying to eliminate "read implies execute" personality(2) setting)
	db 0			; e_ident[8]: EI_ABI (always zero)
	times 7 db 0		; e_ident[9-15]: EI_PAD

	;; at 16: Elf64_Half
	dw 2			; e_type: 2 = "executable file" (aka "object file type")
	;; at 18: Elf64_Half
	dw 62			; e_machine: EM_X86_64 = 62 (aka "machine type")
	;; 			  that is found for Linux in "include/uapi/linux/elf-em.h"

	;; at 20: Elf64_Word
	dd 1			; e_version: always 1
	;; at 24: Elf64_Addr
	dq _start		; e_entry: the address where you want to start running
	;; at 32: Elf64_Off
	dq elf64_program_header - $$
				; e_phoff: offset to program header(s) start - required in
	;; 			;   all executables since they give the actual segments to be
	;;                      ;   to be laid out in memory
	;; at 40: Elf64_Off
	dq 0			; e_shoff: offset to section header(s) start - not required in
	;;                      ; static executables since sections are only important for relocation
	;; at 48: Elf64_Word
	dd 0			; e_flags: processor-specific flags
	;;                      ; (where is this documented in the kernel source code?)
	;;
	;; at 52: Elf64_Half
	dw elf64_file_header_size ; e_ehsize: elf64 file header size
	;; at 54: Elf64_Half
	dw elf64_program_header_entry_size
	;;                      ; e_phentsize: size of one program header entry
	;;
	;; at 56: Elf64_Half
	dw 2			; e_phnum: how many program header entries do we have?
	;; at 58: Elf64_Half
	dw 0 			; e_shentsize: size of one section header entry
	;; at 60: Elf64_Half
	dw 0			; e_shnum: how many section header entries do we have?
	;; at 62: Elf64_Half
	dw 0			; e_shstrndx: section name string table index
	;;
	;; 
elf64_file_header_size equ $ - elf64_file_header
	;;
	;;                      ; compute how big the header was (64 bytes!)

	
elf64_program_header:		; This is our first program header 

	;; at 64: Elf64_Word
	dd 1			; p_type: type of segment, 1 = "loadable segment" (from EOFF document)
	;; at 68: Elf64_Word
	dd 7			; p_flags: segment attributes; 0x1 = execute permission
	;;                      ;                              0x2 = write permission
	;;                      ;                              0x4 = read permission
	;;
	;; at 72: Elf64_Off
	dq 0			; p_offset: offset in file -- where does this segment start in file?
	;; at 80: Elf64_Addr
	dq $$			; p_vaddr: virtual address of the segment in memory
	;; at 88: Elf64_Addr
	dq $$			; p_paddr: reserved for systems with physical addressing
	;; at 96: Elf64_Xword
	dq _data - _start	; p_filesz: size of segment in file -- just from _start to _data
	;; at 104: Elf64_Xword
	dq _data - _start	; p_memsz: size of segment in memory
	;; at 112: Elf64_Xword
	dq 0x1000		; p_align: alignment of the segment. p_offset = p_vaddr MOD p_align
	;;
elf64_program_header_entry_size equ $ - elf64_program_header


elf64_program_header_data:	; This is our second program header, used for data

	;; at 64: Elf64_Word
	dd 1			; p_type: type of segment, 1 = "loadable segment" (from EOFF document)
	;; at 68: Elf64_Word
	dd 0x6			; p_flags: segment attributes; 0x1 = execute permission
	;;                      ;                              0x2 = write permission
	;;                      ;                              0x4 = read permission
	;;
	;; at 72: Elf64_Off
	dq _data - $$		; p_offset: offset in file -- where does this segment start in file?
	;; at 80: Elf64_Addr
	dq _data		; p_vaddr: virtual address of the segment in memory --- ?
	;; at 88: Elf64_Addr
	dq $$			; p_paddr: reserved for systems with physical addressing
	;; at 96: Elf64_Xword
	dq _end - _data		; p_filesz: size of segment in file
	;; at 104: Elf64_Xword
	dq _end - _data		; p_memsz: size of segment in memory
	;; at 112: Elf64_Xword
	dq 0x1000		; p_align: alignment of the segment. p_offset = p_vaddr MOD p_align
	;;

_start:

	;; personality(2) --> changing from "read implies execute" to read does not do so
	mov rdi,0
	mov rax,135		; personality(2)
	syscall
	mov rdi,0xffffffff
	mov rax,135		; personality(2)
	syscall

	call	print_self_map

	mov rdi, 42		; answer to everything
	mov rax, 231		; sys_exit_group
	syscall


print_self_map:

	; int open(pathname, flags, mode)
	mov	rdi,proc_self	; pathname
	mov	rsi,0		; flags
	;
	; (viz., /usr/include/asm-generic/fcntl.h:#define O_RDONLY	00000000)
	;
	mov	rdx,0		; mode
	mov	rax,2		; open(2)
	syscall

	;
	;  At this point, rax now has the file descriptor (or error... ;-) for the file.
	;	
	;  Let's save it in r15 for later
	;
	mov	r15,rax

	; ssize_t read(int fd, void *buf, size_t count)
	mov	rdi,rax	        ; fd
	mov	rsi,buffer	; buffer
	mov	rdx,buffer_size ; count
	mov	rax,0		; read(2)
	syscall

	;
	; At this point, rax now has the number of bytes that were successfully read from the file descriptor
	;	
	;
	;   ssize_t write(int fd, const void *buf, size_t count)
	;
	mov	rdi,1	    	; writing to stdout, fd=1
	mov	rsi,buffer	; buffer
	mov	rdx,rax		; just the number of bytes read
	mov	rax,1		; write(2)
	syscall

	;
	;  close(fd)
	;
	mov	rdi,r15		; recover fd from r15
	mov	rax,3		; close(2)
	syscall

	ret

proc_self: db "/proc/self/maps",0

align   0x1000

_data:

buffer:
	times 4096 db 0
buffer_size equ $ - buffer

_end:

total_size equ $ - $$
