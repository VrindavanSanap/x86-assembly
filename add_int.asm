  section .data
  ; db = define byte
  ; 0xA is newline char
  msg db "Hello world", 0xA
  ; msg_size EQU $- msg calculates the size of the data from the msg label 
  ; to the current location ($), which is the end of the data. This 
  ; effectively gives you the number of bytes that the hello_world string 
  ; occupies, including the newline character.
  msg_size EQU $ - msg

  section .text
  global _start

_start:
  ; ssize_t write(int fd, const void *buf, size_t count)
  ; write syscall returns the number of bytes written to the fd 

  mov r8, 7;
  mov r9, 42;
  add r8, r9
  mov rax, 60   ; Syscall number for sys_exit (60)
  mov rdi, r8   ; Exit code result of addition  
  syscall       ; Invoke the syscall
