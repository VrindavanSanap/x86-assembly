Writing x86_64 assembly language for Linux

### Writing x86_64 assembly language for Linux

Here are the comments from a reasonably recent kernel release in
linux-4.8.6/arch/x86/entry/entry_64.S on the kernel entry point for
x86_64:

>     /*
>      * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
>      *
>      * This is the only entry point used for 64-bit system calls.  The
>      * hardware interface is reasonably well designed and the register to
>      * argument mapping Linux uses fits well with the registers that are
>      * available when SYSCALL is used.
>      *
>      * SYSCALL instructions can be found inlined in libc implementations as
>      * well as some other programs and libraries.  There are also a handful
>      * of SYSCALL instructions in the vDSO used, for example, as a
>      * clock_gettimeofday fallback.
>      *
>      * 64-bit SYSCALL saves rip to rcx, clears rflags.RF, then saves rflags to r11,
>      * then loads new ss, cs, and rip from previously programmed MSRs.
>      * rflags gets masked by a value from another MSR (so CLD and CLAC
>      * are not needed). SYSCALL does not save anything on the stack
>      * and does not change rsp.
>      *
>      * Registers on entry:
>      * rax  system call number
>      * rcx  return address
>      * r11  saved rflags (note: r11 is callee-clobbered register in C ABI)
>      * rdi  arg0
>      * rsi  arg1
>      * rdx  arg2
>      * r10  arg3 (needs to be moved to rcx to conform to C ABI)
>      * r8   arg4
>      * r9   arg5
>      * (note: r12-r15, rbp, rbx are callee-preserved in C ABI)
>      *
>      * Only called from user space.
>      *
>      * When user can change pt_regs->foo always force IRET. That is because
>      * it deals with uncanonical addresses better. SYSRET has trouble
>      * with them due to bugs in both AMD and Intel CPUs.
>      */

As described above, Linux x86_64 system calls do not use the stack, in
contrast to many Unix-family kernels. Instead, Linux system calls use
designated registers for the arguments. As noted above, the registers
for the x86_64 calling sequence are

>     RAX -> system call number
>     RDI -> first argument
>     RSI -> second argument
>     RDX -> third argument
>     R10 -> fourth argument
>     R8 -> fifth argument
>     R9 -> sixth argument

Note that the registers RCX and R11 can be trashed by a call.

RAX will have the return value for a system call.

Negative return values in RAX indicate an error, 0 - errno.

You have at least three good choices for assemblers in the Linux world:
[gas](https://sourceware.org/binutils/docs-2.28/as/index.html),
[nasm](http://www.nasm.us/doc/nasmdoc0.html), and
[yasm](https://www.tortall.net/projects/yasm/manual/html/index.html). I
haven\'t used the [flat assembler
(fasm)](http://flatassembler.net/docs.php?article=manual), but I have
read many good things about it --- it is used to build
[MenuetOS](https://en.wikipedia.org/wiki/MenuetOS) and
[KolibriOS](https://en.wikipedia.org/wiki/KolibriOS), a non-trivial
task.

For example, a \"hello world\" could be coded up like this (NASM
syntax):

>
>         global  _start
>         section .text
>
>     _start:
>
>         ; ssize_t write(int fd, const void *buf, size_t count)
>         mov rdi,1           ; fd
>         mov rsi,hello_world     ; buffer
>         mov rdx,hello_world_size    ; count
>         mov rax,1           ; write(2)
>         syscall
>
>         ; exit(result)
>         mov rdi,0           ; result
>         mov rax,60          ; exit(2)
>         syscall
>
>     hello_world:    db "Hello World!",10
>     hello_world_size EQU $ - hello_world

Points to note here: the label \_start is merely traditional. You can
put any label that you like, since the kernel only cares about the
address, not whatever string you decided to use in assembly language to
identify the address.

