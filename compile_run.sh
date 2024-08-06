if [ -z "$1" ]; then
    echo "Usage ./compile_run.sh <file_name>"
    exit 1
fi

file_name="${1%.*}"
extension="${1##*.}"
if [ "$extension" == "asm" ]; then
    asm_file_name="${file_name}.asm"
    obj_file_name="${file_name}.o"

    # create a elf object file
    nasm -f elf64 ${asm_file_name}
    ld -o ${file_name} ${obj_file_name}
    rm -rf ${obj_file_name}
    ./${file_name}
    echo $?
fi

if [ "$extension" == "c" ]; then
    c_file_name="${file_name}.c"
    gcc ${c_file_name} -o ${file_name}
    ./${file_name}
fi 