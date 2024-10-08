format ELF64 executable 3

segment readable executable

entry $
  xor rax, rax  ; sys_read 
  xor rdi, rdi  ; ARG0 stdin 
  mov rsi, buf  ; ARG1 char *buf
  mov rdx, 80   ; ARG1 size_t buf_size  
  syscall


  ; write to stdout
  mov rax, 1    ; sys_write
  mov rdi, 1    ; ARG0 stdout 
  mov rsi, buf  ; ARG1 char *buf
  mov rdx, 80   ; ARG1 size_t buf_size  
  syscall
  

  ; exit
  xor rdi, rdi ; exit code 0
  mov rax, 60  ; sys_exit
  syscall


 
  
  

segment readable writeable

buf rb 80




