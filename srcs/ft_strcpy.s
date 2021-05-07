section .text
global _ft_strcpy

;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9

_ft_strcpy:
	push	rbp
	mov		rbp, rsp
	push	rdi
	xor		rax, rax
	jmp		.L1

.L1:
	mov		dl, BYTE[rsi + rax]
	mov		BYTE[rdi + rax], dl
	cmp		BYTE[rsi + rax], 0
	je		_exit
	inc		rax
	jmp		.L1

_exit:
	pop		rax
	pop		rbp
	ret
