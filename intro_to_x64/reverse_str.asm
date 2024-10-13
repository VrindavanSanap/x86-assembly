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
;---------------------------------------------------------------------------------------

; reverse_str 
; reverses string buffer 
; inputs:
;   rax: buf addr
;   rdi: buf size
; ouputs:
;   rax: number of bytes written (-1 if error)

reverse_str:
  mov r12, rax
  mov r13, rdi
  mov rax, rdi 
  mov rcx, 2
  xor rdx, rdx
  div rcx
	mov r10, rax 
  mov byte [r12], 'X'

reverse_str_loop:
  
  mov rax, r12
  mov rdi, r13
	ret 






; write_exit_code
; exits program with exit_code (uint8_t) to stdout
; input:
;   rax: exit_code (uint8_t) 
; ouput:
;   - writes exit_code  (uint8_t)  to stdout
write_exit_code:
    

  ; exit
  mov rdi, rax ; move rax to rdi (ARG0 - exitcode) 
  mov rax, 60  ; sys_exit
  syscall



; clean_exit
; input:
;   -
; output:
;   - exits program with exit code 0
; exits cleanly with exit code 0
clean_exit:
  mov rax, 0 ; sys_exit
  call write_exit_code



entry $
  mov rax, buf 
  mov rdi, 80
  call read_console 
  mov  rdi, rax
  mov rax, buf
  call reverse_str
  call write_console
  call clean_exit


 
  

segment readable writeable

buf rb 80

