//
//  echo_fun.asm
//  intro_to_x64 
//
//  Created by Vrindavan Sanap on 2024-10-13.
//

format ELF64 executable 3
segment readable executable



; read_console
; reads input form stdin into a buffer
; inputs:
;   rax : buf addr 
;   rdi : buf size
; outputs:
;   rax : number of bytes read (-1 if error)

read_console:

  mov rsi, rax ; ARG1 char *buf
  mov rdx, rdi ; ARG1 size_t buf_size  

  xor rax, rax  ; sys_read 
  xor rdi, rdi  ; ARG0 stdin 
  syscall
  ret 



; write_console
; writes output from buffer to stdout
; inputs:
;   rax: buf addr
;   rdi: buf size
; ouputs:
;   rax: number of bytes written (-1 if error)

write_console:
  mov rsi, rax ; ARG1 char *buf
  mov rdx, rdi ; ARG1 size_t buf_size  

  mov rax, 1    ; sys_read 
  xor rdi, rdi  ; ARG0 stdin 
  syscall
  ret 

entry $
  mov rax, buf      // arg0
  mov rdi, 80       // arg1
  call read_console // returns number of bytes written into rax

  mov rdi, rax      // arg1
  mov rax, buf      // arg0 
  call write_console 


  ; exit
  xor rdi, rdi ; exit code 0
  mov rax, 60  ; sys_exit
  syscall


segment readable writeable
buf rb 80
