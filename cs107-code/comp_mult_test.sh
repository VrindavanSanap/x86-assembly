#!/bin/bash
: '
	-g:
		•	This option tells GCC to include debugging information in the compiled executable. This debugging information is useful when you need to use a debugger (like gdb) to inspect the program’s execution, set breakpoints, and examine variables.
	-O0:
		•	This option specifies the optimization level for the compilation. -O0 means no optimization. This is useful during development because it ensures that the generated code is as close as possible to the source code, making debugging easier. Without optimizations, debugging tools can give more accurate results since the compiler hasn’t made changes that could obscure the code’s behavior.
    '
gcc -g -O0 mult_test.c -o mult_test