%include "const.inc"
%include "libasm.inc"

global _start

section .text

_start:
	readInput

	xor rax, rax
	xor rbx, rbx
	xor rcx, rcx
	xor r9, r9
	xor r11, r11

	mov r10, 10

get_next_byte:
	readNBytes r8b, 1

parse:
	cmp r8b, 0xA
	jne no_newline

	cmp rbx, rcx
	jle no_new_highest
	mov r11, r9
	mov r9, rcx
	mov rcx, rbx
	jmp continue

no_new_highest:
	cmp rbx, r9
	jle no_new_second
	mov r11, r9
	mov r9, rbx
	jmp continue

no_new_second:
	cmp rbx, r11
	jle continue
	mov r11, rbx

continue:
	cmp r12, 0
	mov r12, 1
	je no_reset

	xor rbx, rbx

no_reset:
	add rbx, rax
	xor rax, rax
	jmp get_next_byte

no_newline:
	xor r12, r12
	mul r10
	sub r8b, 0x30
	add rax, r8
	jmp get_next_byte

exit:
	add rcx, r9
	add rcx, r11
	printDigit rcx 
	exitzero
