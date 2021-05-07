section .text
global _ft_strlen

_ft_strlen:
	xor		rax, rax
	jmp		.L1

.L1:
	cmp		BYTE[rdi + rax], 0
	je		_exit
	inc		rax
	jmp		.L1

_exit:
	ret
