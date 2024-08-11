; Created by vrindavan
; int_div.asm
; Simple program to integer divide two integers
; And ouput the quotient by writing it to exit code
; We will be using the IDIV—Signed Divide instruction
;

section .text
  global _start

_start:
  ; ssize_t write(int fd, const void *buf, size_t count)
  ; write syscall returns the number of bytes written to the fd 

  mov r8, 7;
  mov r9, 42;

  ; add instruction 
  ; Adds immediate value to desination 
  ; syntax: 
  ;   add <dest> <immediate>
  ; 
  add r8, r9


  ; Exit syscall 
  ; Syscall number (rax) : 60
  ; Arg0 (rdi): int error_code
  ;
  mov rax, 60   ; Syscall number for sys_exit (60)
  mov rdi, r8   ; Exit code
  syscall       ; Invoke the syscall
