; Created by Vrindavan sanap
; echo_back.asm 
; Written for nasm assembler 
; expected output format elf64
;
; simple program that takes in string from std in and 
; writes it back
;

section .bss
    buf resb 80 ; reserve 80 bytes for the input buffer 

section .text
global _start


_start:

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

