global _start

section .data 
  msg db "Hello world!", 0x0a
  len equ $ - msg 



section .text
_start: 
  mov ecx, msg    
  mov edx, len    
  xor esi, esi

loop:
  inc esi 
  cmp esi, 10     ; compare esi with 10 
  call print
  jl loop
  call exit

print:
  ; prints given text
  ; arguments:
  ;   arg0-ecx msg
  ;   arg1-edx len 

  mov eax, 4      ; write syscall
  mov ebx, 1      ; stdout fd
  int 0x80
  ret 

exit:
  mov eax, 1      ; exit syscall
  mov ebx, 0      ; status code 0
  int 0x80
  ret 


