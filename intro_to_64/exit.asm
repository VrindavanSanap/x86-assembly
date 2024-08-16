; Program: exit
;
; Executes the exit system call
;
; No input
;
; Output only the exit status ($? = exit status)

segment .text

global _start

_start:
  mov eax, 60     ; 60 is the syscall number for exit
  mov edi, 5      ; the exit status to return 
  syscall
