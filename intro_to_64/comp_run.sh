#!/bin/bash

filename="$1"  # Remove spaces around the '='

# Check if filename is provided
if [ -z "$filename" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

name="${filename%.*}"  # Extract the filename without extension
extension="${filename##*.}"  # Extract the extension

# Correct the yasm command as needed
yasm -f elf64 -g dwarf2 -o "${name}.o" "${filename}"

# Check if yasm succeeded before proceeding
if [ $? -ne 0 ]; then
    echo "yasm failed"
    exit 1
fi

# Link the object file
ld -o "${name}" "${name}.o"

# Check if ld succeeded
if [ $? -ne 0 ]; then
    echo "ld failed"
    exit 1
fi

if [ -x "${name}" ]; then
    echo "Compilation and linking succeeded: ${name}"
    ./"${name}"
    exit_code=$?
    echo "Program exited with code: ${exit_code}"
else
    echo "Executable ${name} not found or not executable"
    exit 1
fi