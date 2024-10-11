global _start 
section .text


_start:
  mov ebx, 42     ; arg0
  mov eax,  1     ; exit syscall
  jmp skip
  mov ebx, 13


skip:
 int 0x80      ; interrupt 
 

