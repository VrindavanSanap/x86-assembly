The C standard library (libc) does not define system calls itself; rather, it provides higher-level abstractions and wrappers for system calls. 

Here’s how it works:

1. **System Calls:** These are low-level operations provided by the operating system kernel. System calls are the interface between user-space applications and the operating system. Examples include `write`, `read`, `open`, and `close`.

2. **libc Wrappers:** The C standard library provides functions that internally make use of system calls. For instance:
   - The `printf` function in libc will eventually call the `write` system call to output text to the terminal.
   - The `fopen` function uses the `open` system call to open files.

3. **Abstraction:** libc abstracts the details of system calls, allowing programmers to use standard C functions without directly dealing with system call numbers or specific kernel-level details. This makes programming more portable and easier, as libc handles the nuances of interacting with the underlying operating system.

4. **Compatibility and Portability:** Libc functions provide a consistent API across different Unix-like systems, ensuring that programs written with standard C library functions can work on various platforms with minimal changes.

In summary, libc uses system calls to perform operations but does not define them. Instead, it provides a more user-friendly and portable interface for performing those operations.