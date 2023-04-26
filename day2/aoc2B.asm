%include "const.inc"
%include "libasm.inc"

global _start

section .text

_start:
	readInput
	xor r11, r11
	mov r10, 0x100

get_next_bytes:
	xor rdx, rdx
	readNBytes r9d, 4

parse:
	sub r9d, 0x580040
	mov rax, r9
	shr rax, 16
	div r10
	mov rax, rdx
	mov rbx, rdx
	xor rdx, rdx
	mov r12, 3
	mul r12
	add r11, rax
	add r9b, bl
	cmp r9b, 1
	jne not_one
	add r9b, 3

not_one:
	cmp r9b, 5
	jne not_five
	sub r9b, 3

not_five:
	sub r9b, 1
	xor r12, r12
	mov r12b, r9b
	add r11, r12
	jmp get_next_bytes

exit:
	printDigit r11
	exitzero
