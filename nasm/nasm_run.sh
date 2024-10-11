#!/bin/bash

filename="$1"  # Remove spaces around the '='

# Check if filename is provided
if [ -z "$filename" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

name="${filename%.*}"  # Extract the filename without extension
extension="${filename##*.}"  # Extract the extension

obj_file="${name}.o"
# Correct the nasm command as needed
nasm -f elf32  "${filename}" -o "${obj_file}" 
ld -m elf_i386 "${obj_file}" -o "${name}"

# Check if nasm succeeded before proceeding
if [ $? -ne 0 ]; then
    echo "nasm failed"
    exit 1
fi


# Check if ld succeeded
if [ $? -ne 0 ]; then
    echo "ld failed"
    exit 1
fi
ELF_DIR="./"  

if [ -x "${name}" ]; then
    echo "Compilation and linking succeeded: ${name}"
    "$ELF_DIR$name"
    echo $? 
    echo "Program exited with code: ${exit_code}"
else
    echo "Executable ${name} not found or not executable"
    exit 1
fi
