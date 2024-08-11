#!/bin/bash

# Check if a file name was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: ./compile_run.sh <file_name>"
    exit 1
fi

# Extract the file name without extension and the file extension
file_name="${1%.*}"
extension="${1##*.}"

# Compile and run an assembly file
if [ "$extension" == "asm" ]; then
    asm_file_name="${file_name}.asm"
    obj_file_name="${file_name}.o"

    # Create an ELF object file
    nasm -f elf64 "$asm_file_name"
    ld -o "$file_name" "$obj_file_name"
    rm -rf "$obj_file_name"
    ./"$file_name"
    echo $?
fi

# Compile and run a C file
if [ "$extension" == "c" ]; then
    c_file_name="${file_name}.c"
    gcc "$c_file_name" -o "$file_name"
    ./"$file_name"
    echo $?
fi
