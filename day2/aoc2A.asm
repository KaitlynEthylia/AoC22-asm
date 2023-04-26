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
	sub r9d, 0x570040
	mov rax, r9
	shr rax, 16
	div r10
	add r11, rdx
	cmp dl, r9b
	je draw
	mov bl, [lookup]
	mov cl, r9b
	shr bl, cl
	and bl, [mask]
	cmp bl, dl
	jne get_next_bytes

	add r11, 3
draw:
	add r11, 3
	jmp get_next_bytes

exit:
	printDigit r11
	exitzero

section .data
lookup: db 0xC
mask: db 0xFB
