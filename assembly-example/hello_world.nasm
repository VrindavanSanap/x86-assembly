
	global	_start
	section	.text

_start:

	; Various demonstration system calls; most edifying to view these
	; via gdb using 'step' and 'info reg'.

	;
	; demonstrate getuid(2)
	;	
	mov	rax,102		; getuid(2) 
	syscall

	;
	; demonstrate getpid(2)
	;
	mov	rax,39		; getpid(2)
	syscall

	;
	; demonstrate getppid(2)
	;
	mov	rax,110		; getppid(2)
	syscall

	; ssize_t write(int fd, const void *buf, size_t count)
	mov	rdi,1			; fd
	mov	rsi,hello_world		; buffer
	mov	rdx,hello_world_size 	; count
	mov	rax,1	 		; write(2)
	syscall

	; exit(result)
	mov	rdi,0			; result
	mov	rax,60			; exit(2)
	syscall

hello_world:	db "Hello World!",10
hello_world_size EQU $ - hello_world
