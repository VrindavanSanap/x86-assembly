; Program: exit
;
; Executes the exit system call
;
; No input
;
; Output only the exit status ($? ubt =)
;

segment .text

global _start


_start:
  mov eax ,1 ; 1 is the exit syscall  number
  mov ebx ,5 ; the syscall value to return 
  int 0x80
