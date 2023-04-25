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

	mov r8, rax
	xor r11, r11
	mov r10, 0x100

get_next_bytes:
	xor rdx, rdx
	cmp rsi, 0
	je exit
	mov r9d, [r8]
	add r8, 4
	sub rsi, 4

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
	mov rax, r11
	mov rbx, 0xA
	mov r10, 0xA

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
	

section .data
path: db "./input", 0
lookup: db 0xC
mask: db 0xFB

section .bss
count: resb 8
