; Created by Vrindavan sanap
; echo_back.asm 
; Written for nasm assembler 
; expected output format elf32
;


global _start
section .data
    msg db "Hell world", 0xA
    len EQU $ - msg 

section .text
_start:
