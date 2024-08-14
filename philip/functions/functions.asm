; Created by Vrindavan sanap
; functions.asm 
; Written for fasm assembler
; 
; Converts read_write.asm into function form 
;

format ELF64 executable 3

segment readable executable 

entry $
  
  mov rax, buf
  mov rdi, 80
  call read_console
 
  mov rax, buf
  mov rdi, 80
  call write_console 

  ; exit the program 
  xor rdi, rdi ; exit code 0
  mov rax, 60  ; exit syscall
  syscall

; read console 
; read input from stdin into a buffer 
; inputs
;   rax : buf addr 
;   rdi : buffer size  
; 
; outputs 
;   rax : number of bytes read 
; 

read_console:
  mov rsi, rax ; buffer address
  mov rdx, rdi ; buffer size

  ; read from stdin 
  xor rdi, rdi ; stdin fd
  xor rax, rax ; read syscall 
  syscall 
  ret 

; function: write console 
; writes the buffer to stdout 
; inputs
;   rax : buf addr 
;   rdi : buffer size  
; 
; outputs 
;   rax : number of bytes read 
; 
write_console:
  mov rsi, rax ; buffer address
  mov rdx, rdi ; buffer size

  ; write to stdout
  mov rdi, 1 ; stdout fd
  mov rax, 1 ; write syscall
  syscall 
  ret
  
segment readable writeable 
buf rb 80
