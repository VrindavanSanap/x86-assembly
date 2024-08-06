if [ -z "$1" ]; then
    echo "Usage ./compile_run.sh <file_name>"
    exit 1
fi

file_name="${1%.*}"
asm_file_name="${file_name}.asm"
obj_file_name="${file_name}.o"

# create a elf object file
nasm -f elf64 ${asm_file_name}
ld -o ${file_name} ${obj_file_name}
rm -rf ${obj_file_name}
./${file_name}
echo $?
