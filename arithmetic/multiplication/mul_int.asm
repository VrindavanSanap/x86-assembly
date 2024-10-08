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
  ; The mul instruction multiplies the unsigned integer in RAX by the unsigned integer in the specified operand.
  ; Syntax: mul <operand>
  ; Input:
  ;   RAX: The first operand and the destination for the lower 64 bits of the result.
  ;   <operand>: The second operand.
  ; Output:
  ;   RDX:RAX: The product of the two operands.


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

