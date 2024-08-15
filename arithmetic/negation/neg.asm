; Created by Vrindavan
; neg.asm
; Trying out the neg instruction in x64 assembly
; Written for nasm assembler
;
; 
section .text
  global _start

_start:
  ; ssize_t write(int fd, const void *buf, size_t count)
  ; write syscall returns the number of bytes written to the fd 

  mov r8, 2;

  ; add instruction 
  ; Negates a value in a register 
  ; syntax: 
  ;   net <dest/immediate>
  ; 

  neg r8;
  mov rax, r8
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

