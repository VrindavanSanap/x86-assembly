; Created by Vrindavan
; sub_int.asm
; Demonstrates subtraction of two integers using add instruction 
; Written for nasm assembler
;
;


section .text
  global _start

_start:
  ; ssize_t write(int fd, const void *buf, size_t count)
  ; write syscall returns the number of bytes written to the fd 

  mov r8, 7;
  mov r9, 42;

  ; sub  instruction 
  ; subtracts immediate value to desination 
  ; syntax: 
  ;   sub <dest> <immediate>
  ; 
  sub r9, r8
  mov rax, r9
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

