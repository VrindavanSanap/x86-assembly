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
	mov r14, rsi
	mov r10, 3

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
   
 


 
 

 

 
 


; uitoa
; converts unsigned interger to ascii  (base 10)
; inputs:
;   rax : string buf
;   rdi : number to convert
; outputs:
;     rax : string buf with converted strign

uitoa: 
  ; handle the case where the number is zero
  mov byte [rax], 48  ; set the first char to '0'
  inc eax             ; move to the next char 
  mov byte [rax], 0   ; zero terminate the string


    
  ; count the number of digits required  
  xor rcx, rcx        ; counter for the number of digits

 
 
 
 
 
 
entry $
  mov rax, buf 
  mov rdi, 80
  call read_console

  mov rdi, rax 
  mov rax, buf 
  call write_n_times 


  ; exit
  xor rdi, rdi ; exit code 0
  mov rax, 60  ; sys_exit
  syscall

 
  

segment readable writeable

buf rb 80




