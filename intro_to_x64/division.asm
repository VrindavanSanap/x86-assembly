format ELF64 executable 3

segment readable executable

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
	mov rax, 13 ; rax contains the dividend 
  mov rcx, 2;
  div rcx;
  ; rax contians quotient 
  ; rdx contians remainder 


	call write_exit_code

