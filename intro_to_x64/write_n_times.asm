;
; write_n_times.asm 
; intro_to_x64
; write a string buffer n times 
; Created by Vrindavan Sanap on 2024-10-13.


format ELF64 executable 3 ;

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



; write_n_times
; writes output from buffer to stdout n times
; inputs:
;   rax: buf addr
;   rdi: buf size
;		rsi: n (number of times to write)
; ouputs:
;   rax: number of bytes written (-1 if error)

write_n_times:
	mov r12, rax
	mov r13, rdi
	mov r10, rsi 

write_n_times_loop:

	mov rax, r12 
	mov rdi, r13 
	mov rsi, r14 
	call write_console
	dec r10 
	jnz write_n_times_loop
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

  mov rdi, rax 
  mov rax, buf 
  mov rsi, 10
  call write_n_times 


  ; exit
  xor rdi, rdi ; exit code 0
  mov rax, 60  ; sys_exit
  syscall

 
  

segment readable writeable

buf rb 80




