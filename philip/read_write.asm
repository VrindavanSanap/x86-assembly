; Created by Vrindavan sanap
; read_write.asm 
; Written for fasm assembler
;
; simple program that takes in string from std in and 
; writes it back
;


format ELF64 executable 3



; buffer of size 80 bytes
segment readable writeable 
buf rb 80


segment readable executable 

entry $
    ; read from stdin 
    xor rdi, rdi ; stdin fd
    mov rsi, buf ; buffer address
    mov rdx, 80  ; buffer size
    xor rax, rax ; read syscall 
    syscall 

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
