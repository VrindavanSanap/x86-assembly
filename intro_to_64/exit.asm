; Program: exit
;
; Executes the exit system call
;
; No input
;
; Output only the exit status ($? = exit status)

section .text

global _start

_start:
  mov rax, 60     ; 60 is the syscall number for exit
  mov rdi, 5      ; the exit status to return 
  syscall
