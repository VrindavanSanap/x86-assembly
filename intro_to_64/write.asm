global _start
_start: 
	mov eax, 1    ; syscall number
	mov ebx, 42   ; arg0 
  sub ebx, 29
	int 0x80
