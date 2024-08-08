; Created by Vrindavan sanap
; functions.asm 
; Written for fasm assembler
;
; 
;


format ELF64 executable 3

segment readable executable 

entry $
    ; write to stdout 
    mov rdi, 1  ; stdout fd
    mov rsi, buf ; buffer address
    mov rdx, 80 ; buffer size
    mov rax, 1  ; write syscall
    syscall

    ; exit the program 
    xor rdi, rdi ; exit code 0
    mov rax, 60  ; exit syscall
    syscall

; read console 
; read input from stdin into a buffer 
; inputs
;   rax : buf addr 
;   rdi : buffer size  
; outputs 
;   rax : number of bytes read 
read_console:
    xor rdi, rdi ; stdin fd
    mov rsi, buf ; buffer address
    mov rdx, 80  ; buffer size
    xor rax, rax ; read syscall 
    syscall 



segment readable writeable 
buf rb 80
