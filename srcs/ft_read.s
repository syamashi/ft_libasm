section .text
global _ft_read
extern ___error

_ft_read:
	push	rbp
	mov		rbp, rsp
	mov		rax, 0x2000003 ; linux:0
	syscall
	jc		_error
	pop		rbp
	ret

_error:
	push	r12
	mov		r12, rax
	call	___error
	pop		QWORD[rax]	; errno_value	
	mov		rax, -1 	; return value
	pop		rbp
	ret
