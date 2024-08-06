  section .data
  ;db= define byte
  ;0xA is newline char
  msg db"Hello world", 0xA
  ; msg_size EQU$- msg calculates the size of the data from the msg label 
  ; to the current location($), which is the end of the data. This 
  ; effectively gives you the number of bytes that the hello_world string 
  ; occupies, including the newline character.
  msg_size EQU $- msg

  section .text
  global _start

_start:
  ; ssize_t write(int fd, const void* buf, size_t count)
  ; write syscall returns the number of bytes successfully written to the file descriptor
  mov rdi, 1; arg0 fd
  mov rsi, msg; arg1 buffer
  mov rdx, 0xff ; arg2 count
  mov rax, 1; write syscall
  syscall
  ; Exit system call

  mov rax, 60; Syscall number for sys_exit(60)
  xor rdi, rdi; Exit code0
  syscall ; Invoke the syscall
