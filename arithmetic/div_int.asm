; Created by Vrindavan
; mul_int.asm
; Demonstrates multiplication of two integers using mul instruction 
; Written for nasm assembler
;
; 
section .text
  global _start

_start:

  mov rdi, 7;
  mov rax, 6;
  mul rdi

  ; mul instruction 
  ; Performs multiplicaion of unsigned integer (operand * rax) 
  ;   add <op> 
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

