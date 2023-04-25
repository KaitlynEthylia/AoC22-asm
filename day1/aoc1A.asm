global _start

section .text

_start:
	mov rdi, path
	xor rsi, rsi
	mov rax, 2
	syscall

	mov rdi, rax
	sub rsp, 144
	mov rsi, rsp
	mov rax, 5
	syscall

	mov rsi, [rsp+48]
	add rsp, 144
	mov r8, rdi
	xor rdi, rdi
	xor r9, r9
	mov r10, 2
	mov rdx, 1
	mov rax, 9
	syscall

	mov rdi, rax

	xor rax, rax
	xor rbx, rbx
	xor rcx, rcx

	mov r10, 10

get_next_byte:
	mov r8b, [rdi]
	inc rdi
	dec rsi

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
	cmp rsi, 0
	je exit
	jmp get_next_byte

no_newline:
	xor r12, r12
	mul r10
	sub r8b, 0x30
	add rax, r8
	cmp rsi, 0
	jne get_next_byte

exit:
	mov rax, rcx
	mov rbx, 0xA

print_loop:
	xor rdx, rdx
	div r10
	add rdx, 0x30
	shl rbx, 8
	mov bl, dl
	cmp rax, 0
	jne print_loop

	mov [count], rbx
	mov rsi, count
	mov rdx, 8
	mov rdi, 1
	mov rax, 1
	syscall

	xor rdi, rdi
	mov rax, 60
	syscall

section .bss
count: resb 8

section .data
path: db "./input"
