; Created by Vrindavan
; div_int.asm
; Demonstrates division of two integers using mul instruction 
; Written for nasm assembler
;
; 
section .text
  global _start

_start:

  mov rdi, 7;
  mov rax, 6;
  mul rdi

  ; div instruction 
  ; Performs div of unsigned integer (operand * rax) 
  ;   div <op2> 
  ; syntax: 
  ; input: 
  ;   Numbers to be multiplied
  ;     op1: rax
  ;     op2: any register 
  ; ouput:
  ;   Result is stored in rdx:rax
  ; 


  call write_exit_code



; function write_exit_code
; writes int to exit code
; inputs 
;   rax : exit code
write_exit_code:
  ; Exit syscall 
  ; Syscall number (rax) : 60
  ; Arg0 (rdi): int error_code
  ;
  mov rdi, rax ; Exit code
  mov rax, 60   ; Syscall number for sys_exit (60)
  syscall       ; Invoke the syscall

