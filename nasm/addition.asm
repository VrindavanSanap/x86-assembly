global _start

_start:
  mov eax, 1  ; syscall number  
  mov ebx, 42 ; arg 0
  add ebx, 42 ; add instruction
  int 0x80

