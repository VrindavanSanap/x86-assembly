; Program: exit
;
; Executes the exit system call
;
; No input
;
; Output only the exit status ($? = exit status)

segment .data
	a dq 100
 	b dq 201
	diff dq 0


segment .text
global _start 

_start:
	push rbp
	mov rbp , rsp
	sub rsp , 16
	mov rax , 10
	sub [a] , rax ; subtract 10 from a
	sub [b] , rax ; subtract 10 from b
	mov rax , [b]	; move b into rax
	sub rax , [a] ; set rax to b-a
	mov [diff] , rax ;  rax move the difference to diff
	mov rax , 0
    mov rax, 60        ; syscall number for exit (60)
    mov rdi, [diff]    ; use the calculated difference as the exit code
    syscall            ; make the syscall