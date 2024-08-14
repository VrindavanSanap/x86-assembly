#!/bin/bash
file_name="${1%.*}"
extension="${1##*.}"

asm_file_name="${file_name}.asm"
obj_file_name="${file_name}.o"

# Check if the file extension is 'asm'
if [ "$extension" == "asm" ]; then
    nasm -f elf32 "$asm_file_name"
    ld -m elf_i386 "$obj_file_name" -o "$file_name"
    ./"$file_name"
    echo $?
else
    echo "Invalid file extension. Only 'asm' files are supported."
fi


