; Created by Vrindavan sanap
; int_to_string.asm 
; Written for fasm assembler
;
; simple program that converts a unsigned int to string (base 10)
;
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

; write console 
; write the buffer to stdout 
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

; uitoa
; converts unsigned int to string (base 10)
; inputs: 
;   rax : string buf
;   rdi : number to convert
;
; outputs:
;   - the buffer is filled with base 10 conversion
;
uitoa: 
  ; handle the case where the number is zero
  mov byte [rax], 48 ; set the first char to '0'
  inc eax
  mov byte [rax], 0 ; zero terminate the string
  goto uitoa_end

  ; handle all the rest of the cases

  ; count the number of digits required for conversion
  xor rcx, rcx  ; use rcx as a counter for number of digits
  mov rsi, rax  ; move the string buffer to rsi
  ; IDV instruction 
  ;
  ; Inputs : 
  ;   Dividend : rax 
  ;   Divisor  : rdx, 
  ;
  ; Outputs: 
  ;   Quotient : rax 
  ;   Remainder: rax 
 



uitoa_end:  
  ret
segment readable writeable 
buf rb 80
