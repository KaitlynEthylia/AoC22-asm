%include "const.inc"
%include "libasm.inc"

global _start

section .text

_start:
	readInput

	xor rax, rax
	xor rbx, rbx
	xor rcx, rcx

	mov r10, 10

get_next_byte:
	readNBytes r8b, 1

parse:
	cmp r8b, 0xA
	jne no_newline

	cmp rbx, rcx
	jle no_new_highest
	mov rcx, rbx

no_new_highest:
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
	printDigit rcx
	exitzero
