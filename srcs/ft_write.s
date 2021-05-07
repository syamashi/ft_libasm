section .text
global	_ft_write
extern	_ft_strlen
extern	___error

;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9
;ssize_t	ft_write(int d, const void *buf, size_t nbytes);

_ft_write:
	push	rbp
	mov		rbp, rsp
	test	edi, edi		; edi & edi ... cmp cannot jl -1
	js		.bad_file_descriptor ; is minus
	cmp		rdi, 10240		; OPEN_MAX
	ja		.bad_file_descriptor
	test	rsi, rsi
	jz		.null
	cmp		rdx, 0			; nbytes = 0
	je		.no_size
	test	edx, edx
	js		.invalid_argument
	push	rdi
	push	rsi
	push	rdx
	mov		rdi, rsi
	call	_ft_strlen
	pop		rdx
	pop		rsi
	pop		rdi
	dec		rdx      		; '\0' count
	cmp		rax, rdx 		; ft_write(1, "", 100000)
	jb		.invalid_argument_inc_rdx
	inc		rdx
	mov		rax, 0x2000004	; linux:1
	syscall
	jc		.error			; error sets carry flag
	pop		rbp
	ret

.bad_file_descriptor:
	call	___error
	mov		QWORD[rax], 9
	mov		rax, -1
	pop		rbp
	ret

.null:
	call	___error
	mov		QWORD[rax], 14
	mov		rax, -1
	jmp		.exit

.no_size:
	mov		rax, 0
	jmp		.exit

.invalid_argument_inc_rdx:
	inc		rdx
	jmp		.invalid_argument

.invalid_argument:
	push	rdx
	call	___error
	pop		rdx
	mov		QWORD[rax], 22
	mov		rax, rdx
	jmp		.exit

.error:
	push	r12
	mov		r12, rax
	push	r12
	call	___error
	pop		QWORD[rax]		; rax is errno pointer
	mov		rax, -1
	jmp		.exit

.exit:
	pop		rbp
	ret
