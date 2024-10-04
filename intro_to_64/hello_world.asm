global _start

section .data 
  msg db "Hello world!", 0x0a
  len equ $ - msg 



section .text
_start: 
  mov eax, 4      ; write syscall
  mov ebx, 1      ; stdout fd
  mov ecx, msg    ; bytes to write 
  mov edx, len    ; number of bytes to write
  int 0x80






