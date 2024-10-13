;
;	echo_fun.asm
;	intro_to_x64 
; complies and runs assembly file written for fasm assembler
;
;	Created by Vrindavan Sanap on 2024-10-13.
;	
fasm "$1"
filename="${1%.*}"

./"${filename%.*}"


