section .bss
digits: resb 8

section .data
path: db "./input", 0

%macro readInput 0
	mov rdi, path
	mov rsi, O_RDONLY
	mov rax, SYS_OPEN
	syscall

	mov rdi, rax
	sub rsp, 144
	mov rsi, rsp
	mov rax, SYS_FSTAT
	syscall

	mov rsi, [rsp+48]
	add rsp, 144
	mov r8, rdi
	xor rdi, rdi
	xor r9, r9
	mov r10, 2
	mov rdx, 1
	mov rax, SYS_MMAP
	syscall

	mov rdi, rax
%endmacro

%macro readNBytes 2
	cmp rsi, 0
	je exit
	mov %1, [rdi]
	add rdi, %2
	sub rsi, %2
%endmacro

%macro printDigit 1
	mov rax, %1
	mov rbx, 0xA
	mov r10, 0xA

%%print_loop:
	xor rdx, rdx
	div r10
	add rdx, 0x30
	shl rbx, 8
	mov bl, dl
	cmp rax, 0
	jne %%print_loop

	mov [digits], rbx
	mov rsi, digits
	mov rdx, 8
	mov rdi, STDOUT
	mov rax, SYS_WRITE
	syscall
%endmacro

%macro exitzero 0
	mov rax, SYS_EXIT
	xor rdi, rdi
	syscall
%endmacro

%macro exitone 0
	mov rax, SYS_EXIT
	mov rdi, 1
	syscall
%endmacro
