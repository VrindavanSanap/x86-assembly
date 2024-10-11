global _start

section .data
  buffer db 100
  msg db "You entered: ", 0x0a
  msg_len equ $ - msg  ; length of the message string

section .text
  
